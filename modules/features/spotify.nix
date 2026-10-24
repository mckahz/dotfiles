{ inputs, ... }: {
  flake-file.inputs.spicetify.url = "github:Gerg-L/spicetify-nix";

  den.aspects.spotify.nixos = { host, pkgs, ... }: {
    imports = [
      inputs.spicetify.nixosModules.default
    ];

    programs.spicetify.enable = true;
  };
}
