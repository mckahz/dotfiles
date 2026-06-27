{ inputs, user, ... }:
{
  imports = [
    inputs.caelestia-shell.homeManagerModules.default
  ];

  programs.caelestia = {
    enable = true;
    cli.enable = true;
    settings = {
      paths.wallpaperDir = "${user.name}/Pictures/Wallpapers";

      dashboard.showOnHover = false;

      bar = {
        status = {
          showAudio = true;
          showMicrophone = true;
          showNetwork = true;
          showWifi = true;
          showBluetooth = true;
          showBattery = true;
          showLockStatus = true;
        };
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
          label = "  ";
          occupiedLabel = "󰮯";
          activeLabel = "󰮯";
          capitalisation = "preserve";
          specialWorkspaceIcons = [ ];
          windowIcons = [ ];
        };
      };
    };
  };
}
