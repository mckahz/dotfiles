{ inputs, pkgs, ... }: {
  wayland.windowManager.hyprland = {
    enable = true;

    package = inputs.hypr.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hypr.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };
}
