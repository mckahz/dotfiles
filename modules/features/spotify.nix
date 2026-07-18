{ inputs, ... }: {
  flake-file.inputs.spotatui.url = "github:LargeModGames/spotatui";

  den.aspects.spotify = {
    nixos = { host, pkgs, ... }: {
      environment.systemPackages = with pkgs; [
        spotify
        librespot
        inputs.spotatui.packages.${host.system}.default
      ];
    };
  };
}
