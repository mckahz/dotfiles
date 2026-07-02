{ user, pkgs, ... }:
let
  nvim = builtins.getFlake "path:${user.root}/flakes/nvim";
in
{
  home.packages = [
    nvim.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
