{ inputs, den, ... }:
{
  den.aspects.keyboard = {
    inputs.keyd.url = "github:rvaiya/keyd";

    nixos =
      {
        pkgs,
        lib,
        config,
        ...
      }:
      {
        options.keyboard = {
          enable = lib.mkOption {
            default = false;
            example = true;
            description = "Whether to map CAPS LOCK to ESC when tapped and CTRL when held";
            type = lib.types.bool;
          };
          device = lib.mkOption {
            example = "/dev/input/by-id/xxxxxxxxxxx-kbd";
            description = "Path to your keyboard device";
            type = lib.types.path;
          };
        };

        config = lib.mkIf config.keyboard.enable {
          services.keyd = {
            enable = true;
            keyboards = {
              # The name is just the name of the configuration file, it does not really matter
              default = {
                ids = [ "*" ]; # what goes into the [id] section, here we select all keyboards
                # Everything but the ID section:
                settings = {
                  # The main layer, if you choose to declare it in Nix
                  main = {
                    # capslock = "layer(control)"; # you might need to also enclose the key in quotes if it contains non-alphabetical symbols
                    capslock = "overload(control, esc)";
                  };
                  otherlayer = {};
                };
                extraConfig = ''
                  # put here any extra-config, e.g. you can copy/paste here directly a configuration, just remove the ids part
                '';
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
  };
}
