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
      device = lib.mkOption {
        type = lib.types.path;
        description = "path to the /dev/ directory representing the keyboard";
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
            config.keyboard.device
          ];
          config = ''
            (defcfg process-unmapped-keys yes)

            (defsrc caps)

            (defalias vim (tap-hold 200 200 esc lctl))

            (deflayer my-keyboard @vim)
          '';
        };
      };
    };
  };
}
