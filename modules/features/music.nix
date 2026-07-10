_: {
  den.aspects.music = {
    nixos = { host, pkgs, ... }: {
      environment.systemPackages = with pkgs; [
        spotify
        # inputs.spotatui.packages.${host.system}.default
      ];
    };
  };
}
