{
  pkgs,
  user,
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

  xdg.configHome = user.config;

  programs.zsh.enable = true;
}
