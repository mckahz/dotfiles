{ pkgs, user, ... }:
{
  programs.fish = {
    enable = true;

    shellAbbrs = {
      nv = "nvim";
    };

    interactiveShellInit = "${user.customConfig}/fish/init.fish";

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
