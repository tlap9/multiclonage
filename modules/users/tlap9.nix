{
  config,
  ...
}:
{
  flake.modules.homeManager.tlap9 = {
    home.username = config.flake.personalUsername;
    home.stateVersion = "24.04";
  };
}
