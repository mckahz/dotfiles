{ pkgs, ... }:
let
  enable = true;
in
{
  programs.fish = {
    inherit enable;

    shellAbbrs = {
      nv = "nvim";
    };

    interactiveShellInit = "";

    plugins =
      let
        plugin = name: {
          name = name;
          src = pkgs.fishPlugins.${name}.src;
        };
      in
      map plugin [
        "grc"
        "z"
        "tide"
      ];
  };
}
