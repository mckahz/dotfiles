{ inputs, ... }: {
  den.aspects.discord.nixos =
    { pkgs, ... }:
    {
      nixpkgs.config.allowUnfree = true;
      environment.systemPackages = with pkgs; [
        (discord.override {
          # withOpenASAR = true; # can do this here too
          withVencord = true;
        })
      ];
    };
}
