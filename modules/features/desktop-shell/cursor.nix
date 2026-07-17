{ inputs, den, ... }: {
  den.aspects.cursor = {
    homeManager = { pkgs, ... }: {
      home = {
        packages = with pkgs; [
          hyprcursor
          bibata-cursors
        ];

        sessionVariables.XCURSOR_THEME = "Bibata-Modern-Ice";
        sessionVariables.HYPRCURSOR_THEME = "Bibata-Modern-Ice";
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
