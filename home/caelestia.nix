{
  pkgs,
  inputs,
  lib,
  user,
  config,
  ...
}:
{
  imports = [
    inputs.caelestia-shell.homeManagerModules.default
  ];

  xdg.configFile."caelestia/themes" = {
    source = config.lib.file.mkOutOfStoreSymlink "${user.root}/caelestia/themes";
    force = true;
    recursive = true;
  };

  programs.caelestia = {
    enable = true;
    settings = {
      bar = {
        status = {
          showAudio = true;
          showMicrophone = true;
          showKbLayout = false;
          showNetwork = true;
          showWifi = true;
          showBluetooth = true;
          showBattery = true;
          showLockStatus = true;
        };
        clock = {
          showDate = true;
          showIcon = false;
        };
      };

      dashboard = {
        enabled = true;
        showOnHover = false;
      };

      background.visualiser = {
        enabled = true;
      };

      general = {
        showOverFullscreen = false;
        apps = {
          terminal = "${pkgs.kitty}";
          audio = "${pkgs.pavucontrol}";
          explorer = "${pkgs.nautilus}";
        };
      };

      launcher = {
        vimKeybinds = true;
      };
    };
  };
}
