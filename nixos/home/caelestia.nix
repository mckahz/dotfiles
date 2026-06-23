{ inputs, ... }:
{
  imports = [
    inputs.caelestia-shell.homeManagerModules.default
  ];

  programs.caelestia = {
    enable = true;
    systemd.enable = true;
    cli.enable = true; # Also adds caelestia-cli to path
  };
}
