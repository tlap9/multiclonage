{ inputs, config, ... }:
let
  username = config.flake.username;
in
{
  flake.modules.nixos.zenbookFtConfiguration =
    { pkgs, ... }:
    {

      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;

      boot.initrd.luks.devices."dm_crypt-0" = {
        device = "/dev/disk/by-uuid/86d34325-0759-418b-8796-c946ed5f2800";
      };

      fileSystems."/" = {
        device = "/dev/disk/by-uuid/81a89763-776e-4003-a848-41ca7f3401b1";
        fsType = "ext4";
      };

      fileSystems."/boot" = {
        device = "/dev/disk/by-uuid/c40a555c-35c5-4b67-9506-eeefc89ed35e";
        fsType = "ext4";
      };

      fileSystems."/boot/efi" = {
        device = "/dev/disk/by-uuid/482A-419E";
        fsType = "vfat";
      };
      networking.wireless.enable = true;
      networking.networkmanager.enable = true;

      time.timeZone = "Europe/Paris";

      i18n.defaultLocale = "fr_FR.UTF-8";

      services.xserver.xkb = {
        layout = "us";
        variant = "altgr-intl";
        options = "caps:escape";
      };

      users.users.${username} = {
        isNormalUser = true;
        description = "FT Tom Laplace";
        extraGroups = [
          "networkmanager"
        ];
      };

      nixpkgs.config.allowUnfree = true;

      nix.settings = {
        experimental-features = [
          "nix-command"
          "flakes"
        ];

        trusted-users = [
          "root"
          "itla2990"
        ];
      };

      environment.systemPackages = with pkgs; [
        accountsservice
        appimage-run
        asusctl
        libgcc
        gcc
        gnumake
      ];

      programs.appimage = {
        enable = true;
        binfmt = true;
      };

      environment.pathsToLink = [
        "/share/applications"
        "/share/xdg-desktop-portal"
      ];

      system.stateVersion = "24.04";

      programs.nix-ld.enable = true;

      services.power-profiles-daemon.enable = true;
      services.upower.enable = true;

      services.supergfxd.enable = true;
      services.asusd.enable = true;
    };
}
