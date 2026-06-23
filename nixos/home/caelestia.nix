{ inputs, ... }:
{
  imports = [
    inputs.caelestia-shell.homeManagerModules.default
  ];

  programs.caelestia = {
    enable = true;
    systemd.enable = true;
    cli.enable = true; # Also adds caelestia-cli to path
    settings = {
      paths = {
        wallpaperDir = "~/Pictures/Wallpapers";
      };
      background = {
        enabled = true;
        wallpaperEnabled = true;
      };
      launcher = {
        enabled = true;
      };
    };
  };
}
