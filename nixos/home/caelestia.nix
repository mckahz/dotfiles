{ inputs, user, ... }:
{
  imports = [
    inputs.niri-caelestia-shell.homeManagerModules.default
  ];

  programs.caelestia = {
    enable = true;
    cli.enable = true;
    settings = {
      paths.wallpaperDir = "${user.name}/Pictures/Wallpapers";

      bar = {
        statusIcons = {
          speakers = true;
          microphone = true;
          network = true;
          wifi = true;
          bluetooth = true;
          battery = true;
        };
        icon.useDistroIcon = true;
        clock.background = true;
        workspaces = {
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
  };
}
