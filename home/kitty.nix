{ lib, ... }:
{
  programs.kitty = lib.mkForce {
    enable = true;
    #shellIntegration.enableZshIntegration = true;
    shellIntegration.enableFishIntegration = true;
    settings = {
      shell = "fish";
      background_opacity = "0.8";
      hide_window_decorations = "yes";
      window_padding_width = 8;
    };

    # extraConfig = ''
    #   include ~/.local/state/caelestia/theme/kitty.conf
    # '';
  };
}
