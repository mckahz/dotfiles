{ ... }: {
  den.aspects.autologin = {
    nixos =
      {
        config,
        pkgs,
        lib,
        ...
      }:
      {
        options.autologin = {
          enable = lib.mkOption { default = true; };
          user = lib.mkOption { type = lib.types.str; };
          session = lib.mkOption { type = lib.types.str; };
        };

        config = lib.mkIf config.autologin.enable {
          services.greetd = {
            enable = true;
            settings = rec {
              initial_session = {
                command = config.autologin.session;
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
  };
}
