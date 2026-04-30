{ ... }:
{
  networking.hostName = "laptop";

  imports = [
    ./hardware-configuration.nix
  ];

  keyboard = {
    enable = true;
    path = ./keyboard.kbd;
  };

  system.stateVersion = "25.11";
}
