{ ... }:
let
  hostName = "laptop";
in
{
  networking.hostName = hostName;

  imports = [
    ./hardware-configuration.nix
  ];

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
