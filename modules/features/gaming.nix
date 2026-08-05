{
  den.aspects.gaming = {
    nixos =
    { pkgs, ... }:

    {
      environment.systemPackages = with pkgs; [
        steam

        shtris

        antimicrox
        wine # exclusively for pkmcc
      ];

      programs.steam.enable = true;
    };
  };
}
