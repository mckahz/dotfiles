{
  inputs,
  user,
  style,
  ...
}:
{
  imports = [
    inputs.dms.homeModules.dank-material-shell
    inputs.dms.homeModules.niri
  ];

  # #systemd.user.services.niri-flake-polkit.enable = false;

  programs.dank-material-shell = {
    enable = true;
    niri = {
      enableSpawn = true; # Auto-start DMS with niri, if enabled
    };

    settings = {
      barConfigs = [
        {
          id = "default";
          name = "Main Bar";
          enabled = true;

          ## Widgets
          leftWidgets = [
            {
              id = "notificationButton";
              enabled = true;
            }
            "workspaceSwitcher"
            "focusedWindow"
          ];
          centerWidgets = [
            {
              id = "clock";
              enabled = true;
            }
          ];
          rightWidgets = [
            {
              id = "music";
              enabled = true;
            }
            {
              id = "easyEffects";
              enabled = true;
            }
            {
              id = "memUsage";
              enabled = true;
            }
            {
              id = "battery";
              enabled = true;
              showPercent = false;
            }
            {
              id = "networkMonitor";
              enabled = true;
            }
            {
              id = "clipboard";
              enabled = true;
            }
            {
              id = "controlCenterButton";
              enabled = true;
              showAudioIcon = true;
              showBatteryIcon = false;
              showBluetoothIcon = true;
              showBrightnessIcon = true;
              showMicIcon = true;
              showNetworkIcon = true;
              showPrinterIcon = false;
              showVpnIcon = true;
            }
            {
              id = "powerMenuButton";
              enabled = true;
            }
            {
              id = "systemTray";
              enabled = true;
            }
          ];

          ## Layout
          position = 2; # 0=top, 1=bottom, 2=left, 3=right
          spacing = 3;
          bottomGap = 1;
          innerPadding = 8; # Sets the bar size, strangely
          maximizeDetection = true; # Don't remove gaps if the window is maxximized

          ## Behavior
          scrollYBehavior = "none";
        }
      ];

      ## Displays
      screenPreferences = [ "all" ];
      showOnLastDisplay = true;

      ## Layout
      innerPadding = 4;
      popupGapsAuto = true;
      popupGapsManual = 4;

      ## Style
      matugenTemplateFirefox = false; # disables creating firefox.css file on manual config change. What are the ramifications?
      transparency = 1;
      widgetTransparency = 1;
      squareCorners = false;
      noBackground = false;
      gothCornersEnabled = false;
      gothCornerRadiusOverride = false;
      gothCornerRadiusValue = 12;
      borderEnabled = true;
      borderColor = "surfaceText";
      borderOpacity = 1;
      borderThickness = 10;

      fontScale = 1;

      ## Icons
      dockIconsize = 24;

      ## Behavior
      visible = true;
      autoHide = false;
      autoHideDelay = 250;
      openOnOverview = false;

      # On Screen Display
      osdPowerProfileEnabled = true;

      ## Workspaces
      showWorkspaceIndex = true;
      showWorkspacePadding = true;
      showWorkspaceApps = true;
      showOccupiedWorkspacesOnly = true;

      ## Dock
      showDock = false;
      dockAutoHide = true;
      dockGroupByApp = false;
      dockOpenOnOverview = true;

      ## Animation
      customAnimationDuration = 100;

      ## Power/Lock screen
      acMonitorTimeout = 300;
      acLockTimeout = 300;
      lockBeforeSuspend = true;
      lockScreenShowPowerActions = true;
      loginctlLockIntegration = true;
      fadeToLockEnabled = true;
      fadeToLockGracePeriod = 5;

      ### Widgets

      ## Clock
      use24HourClock = true;

      ## Weather
      weatherEnabled = true;
      useAutoLocation = true;
      weatherLocation = "Los Angeles, CA";
      weatherCoordinates = "34.1509, 118.4487";
      useFahrenheit = true;

      ## Night Mode
      nightModeEnabled = true;

      ## Wallpaper
      wallpaperPath = "${user.home}/Pictures/Wallpapers/b-001.jpg";

      ## Frame
      frameEnabled = true;
      frameThickness = 4;
      frameRounding = style.cornerRadius * 1.2;
      frameScreenPreferences = [ "all" ];

      ## Theme
      # currentThemeName = "custom";
      # customThemeFile = theme-tokyonight;
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

    enableSystemMonitoring = true; # System monitoring widgets (dgop)
    enableVPN = true; # VPN management widget
    enableDynamicTheming = true; # Wallpaper-based theming (matugen)
    enableAudioWavelength = true; # Audio visualizer (cava)
    enableCalendarEvents = true; # Calendar integration (khal)
    enableClipboardPaste = true; # Pasting items from the clipboard (wtype)
  };

  # quickshell.package = inputs.quickshell; # or your custom package
}
