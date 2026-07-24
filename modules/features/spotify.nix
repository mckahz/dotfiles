{ inputs, ... }: {
  flake-file.inputs.spotatui.url = "github:LargeModGames/spotatui";
  flake-file.inputs.spotatui.inputs.nixpkgs.follows = "nixpkgs";
  flake-file.inputs.spicetify-nix.url = "github:Gerg-L/spicetify-nix";

  den.aspects.spotify = {
    nixos = { host, pkgs, ... }: {
    };

    homeManager = { host, pkgs, ... }: {
      imports = [
        inputs.spicetify-nix.homeManagerModules.spicetify
      ];

      # home.packages = [
      #   inputs.spotatui.packages.${host.system}.default
      # ];

      # services.librespot.enable = true;
      # services.librespot.package = pkgs.librespot;

      programs.spicetify.enable = true;
    };
  };
}
