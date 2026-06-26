{
  pkgs,
  user,
  ...
}:
let
  getExtension =
    file:
    let
      last = builtins.stringLength file - 1;
    in
    builtins.substring (last - 2) last file;
in
{
  imports = map (file: ./home/${file}) (
    builtins.filter (path: getExtension path == "nix") (builtins.attrNames (builtins.readDir ./home))
  );

  home.packages = [
    pkgs.hello
    pkgs.tela-circle-icon-theme
  ];

  home.stateVersion = "26.05";
  home.username = user.name;
  home.homeDirectory = user.home;
  xdg.configHome = user.config;

  home.pointerCursor =
    let
      name = "Bibata_Cursor_Ice";
    in
    {
      gtk.enable = true;
      x11.enable = true;
      name = name;
      size = 48;
      package = pkgs.runCommand "moveUp" { } ''
        mkdir -p $out/share/icons
        ln -s ${
          pkgs.fetchzip {
            url = "https://github.com/ful1e5/Bibata_Cursor/releases/download/v2.0.7/Bibata-Modern-Ice.tar.xz";
            hash = "sha256-SG/NQd3K9DHNr9o4m49LJH+UC/a1eROUjrAQDSn3TAU=";
          }
        } $out/share/icons/${name}
      '';
    };

  programs.direnv.enable = true;
  programs.direnv.enableFishIntegration = true;

}
