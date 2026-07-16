{ ... }: {
  den.aspects.theme = { ... }: {
    homeManager = { pkgs, lib, ... }: {
      home = {
        packages = with pkgs; [
          hyprcursor
          bibata-cursors
        ];

        sessionVariables = {
          ELECTRON_OZONE_PLATFORM_HINT = "wayland";

          XCURSOR_THEME = "Bibata-Modern-Ice";
          XCURSOR_SIZE = lib.mkForce "24";
          HYPRCURSOR_THEME = "Bibata-Modern-Ice";
          HYPRCURSOR_SIZE = lib.mkForce "24";
        };

        pointerCursor = {
          enable = true;
          gtk.enable = true;
          x11.enable = true;
          package = pkgs.bibata-cursors;
          name = "Bibata-Modern-Ice";
          size = 24;
          hyprcursor = {
            enable = true;
            size = 24;
          };
        };
      };

      gtk = {
        enable = true;
        cursorTheme = {
          name = "Bibata-Modern-Ice";
          size = 24;
        };
      };

      dconf.settings = {
        "org/gnome/desktop/interface" = {
          cursor-theme = "Bibata-Modern-Ice";
        };
      };
    };
  };
}
