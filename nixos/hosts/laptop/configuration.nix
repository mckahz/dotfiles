{ pkgs, user, ... }:
{
  networking.hostName = "laptop";

  imports = [
    ./hardware-configuration.nix
  ];

  environment.systemPackages = with pkgs; [
    ciscoPacketTracer9
    vmware-workstation
  ];

  keyboard = {
    enable = true;
    path = ./keyboard.kbd;
  };

  system.stateVersion = "25.11";
}
