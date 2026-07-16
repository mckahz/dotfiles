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
          HYPRCURSOR_THEME = "Bibata-Modern-Ice";
        };
      };

      gtk = {
        enable = true;
        cursorTheme = {
          name = "Bibata-Modern-Ice";
          size = 24;
        };
      };

      # dconf.settings = {
      #   "org/gnome/desktop/interface" = {
      #     cursor-theme = "Bibata-Modern-Ice";
      #   };
      # };

      stylix = {
        enable = true;
        base16Scheme = "${pkgs.base16-schemes}/share/themes/ayu-mirage.yaml";
        polarity = "dark";

        targets.kitty.enable = true;
        targets.nixcord.enable = true;
        targets.noctalia-shell.enable = true;

        targets.firefox = {
          enable = true;
          profileNames = [ "default" ];
        };
        targets.zen-browser = {
          enable = true;
          profileNames = [ "default" ];
        };
      };
    };
  };
}
