{ lib, ... }:
{
  programs.kitty = lib.mkForce {
    enable = true;
    settings = {
      background_opacity = "0.8";
      hide_window_decorations = "yes";
      window_padding_width = 8;
    };
  };
}
