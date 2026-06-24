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
    gruppled-black-cursors
    xwayland-satellite # To make discord use xwayland (work)
    xdg-desktop-portal-gtk # For screensharing
    xdg-desktop-portal-gnome # For screensharing

    # CLI Utilities
    home-manager
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

    # Language Support
    nil
    nixd
  ];

  programs.dconf.enable = true;
  programs.niri.enable = true;
  programs.fish.enable = true;
  users.extraUsers.${user.name} = {
    shell = pkgs.fish;
  };

  programs.nix-ld.enable = true;
  programs.steam.enable = true;

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
