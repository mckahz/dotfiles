{
  inputs,
  ...
}:
{
  imports = [
    inputs.caelestia.homeManagerModules.default
  ];

  programs.caelestia = {
    enable = true;
    systemd.enable = false;
    cli.enable = true; # Also adds caelestia-cli to path
  };
}
