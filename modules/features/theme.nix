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
      home.pointerCursor.enable = true;

      imports = [ inputs.stylix.homeModules.stylix ];

      stylix = {
        enable = true;
        base16Scheme = "${pkgs.base16-schemes}/share/themes/ayu-mirage.yaml";
        image = ./wallpaper.jpg; # make out of store symlink???
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

        autoEnable = true;

        targets.hyprpaper.image.enable = true;
        targets.zen-browser.profileNames = [ "default" ];
      };
    };
}
