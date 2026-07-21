{
  den.aspects.gaming.nixos =
    { pkgs, ... }:

    {
      environment.systemPackages = with pkgs; [ steam ];
      programs.steam.enable = true;
    };
}
