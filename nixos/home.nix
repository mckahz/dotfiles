{
  pkgs,
  inputs,
  user,
  system,
  ...
}:
{
  imports = [
    ./home/niri.nix
  ];

  home.packages = [
    pkgs.hello
    inputs.caelestia-shell.packages.${system}.default
  ];

  home.stateVersion = "26.05";
  home.username = user.name;
  home.homeDirectory = user.home;

  programs.caelestia-shell.enable = true;
  programs.zsh.enable = true;
  programs.niri.enable = true;
  programs.kitty.enable = true;
}
