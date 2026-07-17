{ inputs, ... }: {
  flake-file.inputs.stylix = {
    url = "github:nix-community/stylix";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.theme = { ... }: {
    homeManager = { pkgs, lib, ... }: {
      imports = [ inputs.stylix.homeModules.stylix ];

      stylix = {
        enable = true;
        base16Scheme = "${pkgs.base16-schemes}/share/themes/ayu-mirage.yaml";
        polarity = "dark";

        targets.kitty.enable = true;
        targets.nixcord.enable = true;
        targets.vencord.enable = true;
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
