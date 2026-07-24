{ inputs, ... }: {
  flake-file.inputs.stylix = {
    url = "github:nix-community/stylix";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.theme.homeManager =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    {
      imports = [ inputs.stylix.homeModules.stylix ];

      options = {
        theme = {
          base16Scheme = lib.mkOption {
            default = "${pkgs.base16-schemes}/share/themes/ayu-mirage.yaml"; # mirage
          };
          wallpaper = lib.mkOption {
            default = ./wallpaper.jpg;
          };
          wallpapers = lib.mkOption {
            example = "/home/user/Pictures/Wallpapers";
            type = lib.types.str;
          };
        };
      };

      config = {
        home.pointerCursor.enable = true;

        stylix = {
          enable = true;
          autoEnable = true;
          base16Scheme = config.theme.base16Scheme;
          polarity = "dark";

          icons = {
            enable = true;
            package = pkgs.papirus-icon-theme;
            dark = "Papirus-Dark";
            light = "Papirus-Light";
          };

          opacity = {
            applications = 0.8;
            desktop = 0.8;
            terminal = 0.8;
            popups = 0.8;
          };

          cursor = {
            name = "Bibata-Modern-Ice";
            package = pkgs.bibata-cursors;
            size = 32;
          };

          targets.hyprpaper.image.enable = true;
          targets.zen-browser.profileNames = [ "default" ];
        };
      };
    };
}
