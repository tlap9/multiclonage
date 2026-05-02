{ inputs, config, ... }:
let
  username = config.flake.username;
  helpers = config.flake.helpers;
in
{
  flake.modules.nixos.terminal =
    { pkgs, ... }:
    {
      users.users.${username}.shell = pkgs.zsh;
    };

  flake.modules.homeManager.terminal =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    let
      ghosttyWrapped = (config.lib.nixGL.wrap pkgs.ghostty).overrideAttrs (old: {
        meta = (old.meta or { }) // { mainProgram = "ghostty"; };
      });
      ghosttyPackage =
        if pkgs.stdenv.isDarwin then pkgs.ghostty-bin
        else if config.targets.genericLinux.enable then ghosttyWrapped
        else pkgs.ghostty;
    in
    {
      targets.genericLinux = {
        enable = pkgs.stdenv.isLinux;
        nixGL = {
          packages = inputs.nixGL.packages.${pkgs.stdenv.hostPlatform.system};
          defaultWrapper = "nvidia";
        };
      };

      home.file."${helpers.mkHomePath config "/Scripts"}" = {
        source = helpers.mkAssetsPath "/scripts";
        recursive = true;
        force = true;
      };

      home.file."${helpers.mkConfigPath config "/.env.template"}" = {
        source = helpers.mkAssetsPath "/env.template";
        force = true;
      };

      home.sessionVariables = {
        LC_ALL = "fr_FR.UTF-8";
        LC_CTYPE = "fr_FR.UTF-8";
        TMPDIR = "$HOME/.tmp";

        DEV = "$HOME/Developer";

        SSH_AUTH_SOCK = "$HOME/.ssh/proton-pass-agent.sock";

        SHELL_SESSIONS_DISABLE = 1;

        TERMINAL = "ghostty";
      };

      home.shell.enableShellIntegration = true;

      programs.ghostty = {
        enable = true;
        package = ghosttyPackage;
        enableZshIntegration = true;
        settings = {
          macos-titlebar-style = "hidden";
          macos-option-as-alt = true;
          window-padding-x = 12;
          window-padding-y = 12;
          working-directory = "home";
          window-inherit-working-directory = false;
          window-save-state = "never";
        };
      };

      programs.zsh = {
        enable = true;
        oh-my-zsh.enable = true;

        # Enable built-in completions (faster than oh-my-zsh)
        enableCompletion = false;
        completionInit = ''
          autoload -Uz compinit
          # Only regenerate .zcompdump once a day for faster startup
          if [[ -n ~/.zcompdump(#qN.mh+24) ]]; then
            compinit
          else
            compinit -C
          fi
        '';

        shellAliases = {
          "c" = "clear";
          "lzd" = "lazydocker";
          "lg" = "lazygit";
          "k9s" = "k9s";
        };

        initContent =
          let
            zshConfigEarlyInit = lib.mkOrder 500 ''
              source ~/.runtimerc 2>/dev/null || true

              delete_localonly_branches () {
                git fetch -p

                for branch in $(git branch --format "%(refname:short)"); do
                  if ! git show-ref --quiet refs/remotes/origin/$branch; then
                    echo "Delete local $branch"
                    git branch -D $branch
                  fi
                done
              }

              alias delete_localonly_branch="delete_localonly_branches"

              # Load cached environment variables
              CACHE_FILE="$HOME/.cache/env/.env.cache"

              if [ -f "$CACHE_FILE" ]; then
                source "$CACHE_FILE"
              else
                echo "⚠️  No cached environment variables found. Running: ~/Scripts/secure-env-refresh"
                ~/Scripts/secure-env-refresh.sh
                source "$CACHE_FILE"
              fi
            '';
          in
          lib.mkMerge [
            zshConfigEarlyInit
          ];
      };

      programs.starship = {
        enable = true;
        settings = {
          command_timeout = 1000;
          format = "$character$directory";
          right_format = "$all";

          # Disable slow/unused modules for faster prompt rendering
          ruby.detect_variables = [ ];
          aws.disabled = true;
          gcloud.disabled = true;
          package.disabled = true;

          cmd_duration = {
            min_time = 0;
            show_milliseconds = false;
          };

          # Git optimizations - only check in git dirs, skip slow operations
          git_status = {
            disabled = false;
            ignore_submodules = true;
          };
        };
      };

      programs.zellij = {
        enable = true;
        enableZshIntegration = false;
        attachExistingSession = false;

        settings = {
          theme = "catppuccin-macchiato";
          simplified_ui = true;
          default_shell = "zsh";
          copy_on_select = true;
          show_startup_tips = false;
        };
      };

    };
}
