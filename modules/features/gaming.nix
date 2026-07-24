{
  den.aspects.gaming.nixos =
    { pkgs, ... }:

    {
      environment.systemPackages = with pkgs; [
        steam

        wineWow64Packages.stableFull
        wineWow64Packages.staging
        wineWow64Packages.waylandFull
        wine
        winetricks
        antimicrox
      ];

      programs.steam.enable = true;
    };
}
