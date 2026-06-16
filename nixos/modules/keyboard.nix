{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    keyboard = {
      enable = lib.mkEnableOption "enables keyboard macros with kanata";
      path = lib.mkOption {
        type = lib.types.path;
        description = "The path to the .kbd file used on the device";
      };
    };
  };

  config = lib.mkIf config.keyboard.enable {
    environment.systemPackages = [ pkgs.kanata ];

    services.kanata = {
      enable = true;
      keyboards = {
        myKeyboard = {
          devices = [
            "/dev/input/by-path/platform-i8042-serio-0-event-kbd"
          ];
          configFile = config.keyboard.path;
        };
      };
    };
  };
}
