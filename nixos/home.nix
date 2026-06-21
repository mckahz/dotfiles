{ pkgs, inputs, ... }:
{
  imports = [
    inputs.niri-flake.homeModules.niri
    <home-manager/nixos>
  ];

  home.packages = [
    pkgs.hello
  ];

  programs.bash.enable = true;

  # The state version is required and should stay at the version you
  # originally installed.
  home.stateVersion = "26.05";

  programs.niri.enable = true;
}
