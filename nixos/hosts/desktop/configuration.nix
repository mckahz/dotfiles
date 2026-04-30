{ ... }:
let
  hostName = "desktop";
in
{
  networking.hostName = hostName;

  imports = [
    ./hardware-configuration.nix
  ];

  nvidia.enable = true;

  keyboard = {
    enable = true;
    path = ./keyboard.kbd;
  };

  home = {
    enable = true;
    host = hostName;
  };

  system.stateVersion = "25.11";
}
