{ inputs, ... }: {
  imports = [
    inputs.dms.homeModules.dank-material-shell
    inputs.dms.homeModules.niri
  ];

  systemd.user.services.niri-flake-polkit.enable = false;

  programs.dank-material-shell = {
    enable = true;
    niri = {
      enableKeybinds = true; # Sets static preset keybinds
      enableSpawn = true; # Auto-start DMS with niri, if enabled
    };

    settings = {
      theme = "dark";
      dynamicTheming = true;
      # Add any other settings here
    };

    session = {
      isLightMode = false;
    };

    clipboardSettings = {
      maxHistory = 25;
      maxEntrySize = 5242880;
      autoClearDays = 1;
      clearAtStartup = true;
      disabled = false;
      disableHistory = false;
      disablePersist = true;
    };
  };

  # Core features
  enableSystemMonitoring = true; # System monitoring widgets (dgop)
  enableVPN = true; # VPN management widget
  enableDynamicTheming = true; # Wallpaper-based theming (matugen)
  enableAudioWavelength = true; # Audio visualizer (cava)
  enableCalendarEvents = true; # Calendar integration (khal)
  enableClipboardPaste = true; # Pasting items from the clipboard (wtype)

  quickshell.package = inputs.quickshell; # or your custom package
}
