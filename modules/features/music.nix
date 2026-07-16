_: {
  den.aspects.music = {
    nixos = { host, pkgs, ... }: {
      environment.systemPackages = with pkgs; [
        librespot # ???
        spotify
        # inputs.spotatui.packages.${host.system}.default
      ];
    };
  };
}
