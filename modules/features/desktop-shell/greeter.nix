{ ... }: {
  den.aspects.greeter = {
    nixos =
      {
        config,
        pkgs,
        lib,
        ...
      }:
      {
        options.autologin = {
          enable = lib.mkOption {
            default = false;
          };
          user = lib.mkOption {
            type = lib.types.str;
          };
        };

        config = lib.mkIf config.autologin.enable {
          security.pam.services.hyprlock = { };

          services.greetd = {
            enable = true;
            settings = rec {
              initial_session = {
                command = "${pkgs.hyprland}/bin/start-hyprland";
                user = config.autologin.user;
              };
              default_session = initial_session;
            };
          };

          environment.etc."greetd/environments".text = ''
            fish
            bash
            start-hyprland
          '';
        };
      };

    homeManager =
      {
        config,
        pkgs,
        lib,
        ...
      }:
      {
        options.lock = {
          enable = lib.mkOption { default = true; };
        };

        config = lib.mkIf config.lock.enable {
          programs.hyprlock = {
            enable = true;
            settings = { };
          };
        };
      };
  };
}
