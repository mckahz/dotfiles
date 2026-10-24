{ inputs, ... }: {
  flake-file.inputs.millennium.url = "github:nolight132/millennium-nix";

  den.aspects.gaming.nixos = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      shtris
      antimicrox
      wine # exclusively for pkmcc
    ];

    nixpkgs.overlays = [ inputs.millennium.overlays.default ];

    programs.steam = {
      enable = true;
      package = pkgs.millennium-steam;
    };
  };
}
