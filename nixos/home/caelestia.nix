{ inputs, ... }:
{
  imports = [
    inputs.niri-caelestia-shell.homeManagerModules.default
  ];

  programs.caelestia = {
    enable = true;
    #systemd.enable = true;
    cli.enable = true; # Also adds caelestia-cli to path
    settings = {
      bar.workspaces = {
        shown = 5;
        activeIndicator = true;
        occupiedBg = false;
        showWindows = true;
        showWindowsOnSpecialWorkspaces = true;
        maxWindowIcons = 5;
        activeTrail = false;
        perMonitorWorkspaces = true;
        label = "a";
        occupiedLabel = "b";
        activeLabel = "c";
        capitalisation = "preserve";
        specialWorkspaceIcons = [ ];
        windowIcons = [ ];
      };
    };
  };
}
