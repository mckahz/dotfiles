{ inputs, ... }: {
  flake-file.inputs = {
    noctalia.url = "github:noctalia-dev/noctalia/cachix";
    # noctalia.inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.noctalia = { ... }: {
    nixos = { lib, pkgs, ... }: {
      networking.networkmanager.enable = lib.mkForce true;
      hardware.bluetooth.enable = lib.mkForce true;
      services.power-profiles-daemon.enable = lib.mkForce true;
      services.upower.enable = lib.mkForce true;

      environment.systemPackages = [
        inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
      ];
    };

    hjem = {
      files.".config/noctalia/config.toml".source = "/home/mckahz/.dotfiles/modules/features/noctalia/config.toml";
    };
  };
}
