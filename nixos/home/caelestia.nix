{ inputs, ... }:
{
  imports = [
    inputs.caelestia-shell.homeManagerModules.default
  ];

  programs.caelestia = {
    enable = false;
    #systemd.enable = true;
    cli.enable = true; # Also adds caelestia-cli to path
    settings = {
      # paths = {
      #   wallpaperDir = "~/Pictures/Wallpapers";
      # };

      # bar.workspaces = {
      #   shown = 5;
      #   activeIndicator = true;
      #   occupiedBg = false;
      #   showWindows = true;
      #   showWindowsOnSpecialWorkspaces = true;
      #   maxWindowIcons = 5;
      #   activeTrail = false;
      #   perMonitorWorkspaces = true;
      #   label = "a";
      #   occupiedLabel = "b";
      #   activeLabel = "c";
      #   capitalisation = "preserve";
      #   specialWorkspaceIcons = [ ];
      #   windowIcons = [ ];
      # };

      # background = {
      #   enabled = true;
      #   wallpaperEnabled = true;
      # };

      # launcher = {
      #   enabled = true;
      # };
    };
  };
}
