_: {
  den.aspects.browser = {
    nixos = { pkgs, ... }: {
      environment.systemPackages = [ pkgs.firefox ];
    };
  };
}
