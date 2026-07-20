{ inputs, ... }: {
  flake-file.inputs.spotatui.url = "github:LargeModGames/spotatui";

  den.aspects.torrent = {
    nixos =
      {
        config,
        host,
        pkgs,
        ...
      }:
      {
        environment.systemPackages = with pkgs; [
          transmission_4-qt
        ];

        services.transmission.settings = {
          download-dir = "${config.services.transmission.home}/Downloads";
        };
      };
  };
}
