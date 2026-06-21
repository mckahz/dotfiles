{
  pkgs,
  user,
  inputs,
  lib,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    # Ricing
    # quickshell pavucontrol
    nwg-look # To apply themes without editing gtk text files
    papirus-nord # Icon theme
    gruppled-black-cursors
    xwayland-satellite # To make discord use xwayland (work)
    xdg-desktop-portal-gtk # For screensharing
    xdg-desktop-portal-gnome # For screensharing

    # CLI Utilities
    btop # System Monitor
    cmatrix # Matrix hacker thingy
    imagemagick # Edit images
    caligula # Burn ISOs to drives
    ani-cli
    # inputs.spotatui.packages.${pkgs.stdenv.hostPlatform.system}.default

    # GUI Applications
    qview # Image viewer
    nautilus # File manager
    krita # Image editor
    libreoffice # Document editor
    firefox
    librespot
    spotify
    discord
    zoom-us
    steam

    # Programming
    zed-editor
    git
    gh
    godot_4
    kitty

    # Language Support
    nil
    nixd
  ];

  programs.niri.enable = true;
  programs.dms-shell = {
    enable = true;
    enableSystemMonitoring = true;
    # enableVPN = true;
    enableDynamicTheming = true;
    enableAudioWavelength = true;
    enableCalendarEvents = true;
    enableClipboardPaste = true;

    quickshell.package = inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.quickshell;
  };
  programs.nix-ld.enable = true;
  programs.steam.enable = true;
  programs.zsh = {
    enable = true;

    ohMyZsh = {
      enable = true;
      plugins = [
        "git"
        "z"
      ];
      custom = "${user.config}/zsh";
      theme = "headline";
    };

    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;

    histSize = 10000;
    histFile = "$HOME/.zsh_history";
    setOptions = [
      "HIST_IGNORE_ALL_DUPS"
    ];
  };

  users.extraUsers.${user.name} = {
    shell = pkgs.zsh;
  };
  # programs.bash.promptInit = ''PS1="\n\[$(tput setaf 39)\]@ \w \n\[$(tput sgr0)\]$ "'';
  programs.direnv = {
    enable = true;
    # enableBashIntegration = true;
    enableZshIntegration = true;
  };
  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;
  services.printing.enable = true;
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
}
