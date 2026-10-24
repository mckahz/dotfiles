{ inputs, den, ... }:
{
  den.aspects.keyboard.nixos =
    {
      lib,
      config,
      ...
    }:
    {
      options.keyboard = {
        enable = lib.mkEnableOption {
          default = true;
          description = "Whether to map CAPS LOCK to ESC when tapped and CTRL when held";
        };
      };

      config = lib.mkIf config.keyboard.enable {
        services.keyd = {
          enable = true;
          keyboards.default = {
            ids = [ "*" ]; # what goes into the [id] section, here we select all keyboards
            settings.main = {
              # capslock = "layer(control)"; # you might need to also enclose the key in quotes if it contains non-alphabetical symbols
              capslock = "overload(control, esc)";
            };
          };
        };

        # Optional, but makes sure that when you type the make palm rejection work with keyd
        # https://github.com/rvaiya/keyd/issues/723
        environment.etc."libinput/local-overrides.quirks".text = ''
          [Serial Keyboards]
          MatchUdevType=keyboard
          MatchName=keyd virtual keyboard
          AttrKeyboardIntegration=internal
        '';
      };
    };
}
