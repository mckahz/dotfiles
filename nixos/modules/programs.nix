{ pkgs, user, ... }:
{
  environment.systemPackages = with pkgs; [
    # Ricing
    # quickshell pavucontrol
    nwg-look # To apply themes without editing gtk text files
    papirus-nord # Icon theme
    gruppled-black-cursors
    xwayland-satellite # To make discord use xwayland (work)

    # CLI Utilities
    btop # System Monitor
    cmatrix # Matrix hacker thingy
    imagemagick # Edit images
    caligula # Burn ISOs to drives
    ani-cli
    inputs.spotatui.packages.${pkgs.stdenv.hostPlatform.system}.default

    # GUI Applications
    qview # Image viewer
    nautilus # File manager
    krita # Image editor
    libreoffice # Document editor
    ciscoPacketTracer8
    vmware-workstation
    firefox
    librespot
    spotify
    discord
    zoom-us
    steam

    # Programming
    zed-editor
    kitty
    git
    gh
    godot_4

    # Language Support
    nil
    nixd
  ];

  programs.bash.promptInit = ''PS1="\n\[$(tput setaf 39)\]@ \w \n\[$(tput sgr0)\]$ "'';
  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
  };
  programs.nix-ld.enable = true;
  programs.steam.enable = true;
  programs.niri.enable = true;
  services.upower.enable = true;
  services.printing.enable = true;
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  programs.dank-material-shell.greeter = {
    enable = true;
    compositor.name = "niri";
    configHome = user.home;
  };
}
