{ inputs, ... }: {
  flake-file.inputs.stylix = {
    url = "github:nix-community/stylix";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.theme = { ... }: {
    homeManager = { pkgs, lib, ... }: {
      imports = [ inputs.stylix.homeModules.stylix ];

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

      stylix = {
        enable = true;
        targets.kitty.enable = true;
        base16Scheme = "${pkgs.base16-schemes}/share/themes/ayu-mirage.yaml";
      };
    };
  };
}
