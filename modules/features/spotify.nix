{ inputs, ... }: {
  flake-file.inputs.spotatui.url = "github:LargeModGames/spotatui";
  flake-file.inputs.spotatui.inputs.nixpkgs.follows = "nixpkgs";
  flake-file.inputs.spicetify.url = "github:Gerg-L/spicetify-nix";

  den.aspects.spotify.nixos = { host, pkgs, ... }: {
    imports = [
      inputs.spicetify.nixosModules.default
    ];

    programs.spicetify.enable = true;
  };
}
