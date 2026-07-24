# All modules in the modules/ directory follow the following structure-
# `inputs` is an attribute set containing all the flakes your project uses.
# You can see all the flakes your project uses in `flake.nix`.
# `den` is how you'll access your aspects. e.g. den.aspects.template
{ inputs, den, ... }: {
  # this is where you add additional inputs to your project.
  flake-file.inputs = {
    # For example-
    # noctalia.url = "github:user:repo";
    # hyprland.url = "github:user:repo";
  };

  # This is how you declare an aspect. Once declared, don't forget to
  # add it to your user's includes and run `git add .`
  den.aspects.template = {
    nixos =
      {
        config,
        pkgs,
        lib,
        ...
      }:
      {
        # This is where nixos module configuration goes. For example-
        # environment.systemPackages = with pkgs; [ git vim neovim ];
      };

    homeManager =
      {
        config,
        pkgs,
        lib,
        ...
      }:
      {
        # This is where home module configuration goes. For example-
        # home.packages = with pkgs; [ git vim neovim ];
      };
  };

}
