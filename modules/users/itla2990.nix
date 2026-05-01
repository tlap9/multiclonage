{
  config,
  ...
}:
{
  flake.modules.homeManager.itla2990 = {
    home.username = config.flake.username;
    home.stateVersion = "26.05";
  };
}