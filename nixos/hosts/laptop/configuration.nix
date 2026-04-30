# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, ... }:
{
  networking.hostName = "laptop"; # Define your hostname.

  imports = [
    ./hardware-configuration.nix
  ];

  keyboard = {
    enable = true;
    path = ./keyboard.kbd;
  };

  system.stateVersion = "25.11"; # Did you read the comment?
}
