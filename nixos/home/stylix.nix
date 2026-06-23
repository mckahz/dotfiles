{ pkgs, inputs, ... }:
{
  imports = [
    inputs.stylix.homeModules.stylix
  ];

  stylix = {
    enable = false;
    polarity = "dark";
    targets.kitty.colors.enable = true;
    image = pkgs.fetchurl {
      url = "https://getwallpapers.com/wallpaper/full/1/4/3/523784.jpg";
      hash = "sha256-S/6kgloXiIYI0NblT6YVXfqELApbdHGsuYe6S4JoQwQ=";
    };
  };
}
