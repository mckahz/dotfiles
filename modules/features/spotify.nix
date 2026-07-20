{ inputs, ... }: {
  flake-file.inputs.spotatui.url = "github:LargeModGames/spotatui";
  flake-file.inputs.spicetify-nix.url = "github:Gerg-L/spicetify-nix";

  den.aspects.spotify = {
    homeManager = { host, pkgs, ... }: {
      imports = [
        inputs.spicetify-nix.homeManagerModules.spicetify
      ];

      home.packages = with pkgs; [
        #spotify
        # librespot
        # inputs.spotatui.packages.${host.system}.default
      ];

      programs.spicetify.enable = true;
    };
  };
}
