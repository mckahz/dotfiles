{ ... }: {
  den.aspects.terminal = {
    nixos = { pkgs, ... }: {
      environment.systemPackages = [ pkgs.kitty ];
    };
    homeManager = { pkgs, ... }: {
      programs.kitty.enable = true;
    };
  };
}
