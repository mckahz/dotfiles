{
  pkgs,
  user,
  inputs,
  lib,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    home-manager

    nerd-fonts.meslo-lg

    xdg-desktop-portal-gtk # For screensharing
    xdg-desktop-portal-gnome # For screensharing

    # CLI Utilities
    btop # System Monitor
    cmatrix # Matrix hacker thingy
    imagemagick # Edit images
    caligula # Burn ISOs to drives
    ani-cli

    # GUI Applications
    qview # Image viewer
    nautilus # File manager
    krita # Image editor
    libreoffice # Document editor
    librespot # ???
    firefox # Browser

    spotify
    # inputs.spotatui.packages.${pkgs.stdenv.hostPlatform.system}.default

    xwayland-satellite # To make discord use xwayland (work)
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
    fish-lsp
  ];

  programs.dconf.enable = true;
  # programs.niri.enable = true;
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };
  programs.programs.uwsm = {
    enable = true;
    waylandCompositors = {
      niri = {
        prettyName = "niri";
        comment = "niri compositor managed by UWSM";
        binPath = "${pkgs.niri}";
      };
    };
  };

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
