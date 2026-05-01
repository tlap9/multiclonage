{ inputs, config, ... }:
let 
  username = config.flake.username;
  helpers = config.flake.helpers;
  overlays = [
    inputs.devenv.overlays.default
  ];
in
{
  flake.modules.nixos.coding =
    { pkgs, ... }:
    {
      nixpkgs.overlays = overlays;

      programs.nix-ld.enable = true;
      programs.nix-ld.libraries = with pkgs; [
        brotli
        unixodbc
        libGL
        glib
        stdenv.cc.cc
        zlib
        openssl
        curl
        bzip2
        libffi
        sqlite
        readline
        xz
        libyaml
        gdbm
        ncurses
        attr
        acl
        libsodium
        util-linux
        libssh
        libxml2
        zstd
      ];

      environment.systemPackages = with pkgs; [
        jetbrains.idea
      ];
    };

  flake.modules.homeManager.coding = helpers.mkHybrid {
    common = 
      { pkgs, config, ... }:
      {
        home.file."${helpers.mkConfigPath config "/git/gitconfig-francetravail"}" = {
          source = helpers.mkAssetsPath "/gitconfig-francetravail";
          force = true;
        };

        home.packages = [
          pkgs.devenv
          pkgs.lazydocker
          pkgs.lazygit
          pkgs.k9s
          pkgs.vscode
        ]
        ++ [
          inputs.tree-sitter.packages.${pkgs.stdenv.hostPlatform.system}.default
        ];

        programs.mise = {
          enable = true;
          enableZshIntegration = true;
          globalConfig = {
            settings = {
              all_compile = false;
            };
            tools = {
              java = "temurin-25";
              nodejs = "24.13.0";
              golang = "1.26.0";
            };
          };
        };

        programs.git = {
          enable = true;
          ignores = [
            ".bloop/"
            ".DS_STORE"
          ];
          settings = {
            user.email = "tlap9@pm.me";
            user.name = "tlap9";
            pull.rebase = "true";
            init.defaultBranch = "main";
          };

          includes = [
            {
              path = helpers.mkConfigPath config "/git/gitconfig-francetravail";
              condition = "gitdir:**/itla2990/**";
            }
          ];
        };

        programs.direnv = {
          enable = true;
          enableZshIntegration = true;
          nix-direnv.enable = true;
          mise.enable = true;
        };
      };
  };
}