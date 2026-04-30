{ ... }:

{
  networking.hostName = "desktop";

  imports = [
    ./hardware-configuration.nix
  ];

  nvidia.enable = true;

  keyboard = {
    enable = true;
    path = ./keyboard.kbd;
  };

  system.stateVersion = "25.11";
}
