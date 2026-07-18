{ inputs, ... }: {

  flake-file.inputs = {
    noctalia-greeter = {
      url = "github:noctalia-dev/noctalia-greeter";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  den.aspects.greeter = {
    nixos =
      {
        config,
        pkgs,
        lib,
        ...
      }:
      {
        imports = [
          inputs.noctalia-greeter.nixosModules.default
        ];

        options.greeter = {
          enable = lib.mkOption {
            default = true;
          };
        };

        config = lib.mkIf config.greeter.enable {
          programs.noctalia-greeter = {
            enable = true;
            greeter-args = "--session Hyprland";
            settings.keyboard.layout = "us";
          };
        };
      };

  };
}
