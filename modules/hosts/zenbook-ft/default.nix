{ inputs, config, ...}:
let
  nixos = config.flake.modules.nixos;
  username = config.flake.username;
  hm = config.flake.modules.homeManager;
in
{
  flake.nixosConfigurations.zenbook-ft = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      # system level configuration
      nixos.zenbookFtConfiguration
      nixos.coding
      nixos.terminal

      # home level configuration
      inputs.home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.${username} = {
          imports = [
            hm.itla2990
            hm.coding
            hm.terminal
          ];
        };
      }
    ];
  };
}