{
  pkgs,
  inputs,
  user,
  system,
  ...
}:
{
  imports = map (file: ./home/${file}) (builtins.attrNames (builtins.readDir ./home));

  home.packages = [
    pkgs.hello
  ];

  home.stateVersion = "26.05";
  home.username = user.name;
  home.homeDirectory = user.home;

  programs.zsh.enable = true;
  programs.kitty.enable = true;
}
