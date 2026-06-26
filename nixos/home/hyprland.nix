{ ... }: {
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false; # Conflict with UWSM
    configType = "lua";
    extraConfig = builtins.readFile ./hyprland.lua

    package = null;
    portalPackage = null;
  };
}
