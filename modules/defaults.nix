{ lib, den, ... }:
{
  den.default = {
    homeManager.home.stateVersion = "26.05";
    nixos.system.stateVersion = "25.11";

    nixos = {
      networking.networkmanager.enable = true;
      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };

  # enable hm by default
  den.schema.user.classes = lib.mkDefault [ "homeManager" ];
}
