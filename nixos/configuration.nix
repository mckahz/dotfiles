# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, inputs, ... }:
{
  security.pam.loginLimits = [
    {
      domain = "*";
      type = "soft";
      item = "nofile";
      value = "65536";
    }
    {
      domain = "*";
      type = "hard";
      item = "nofile";
      value = "1048576";
    }
  ];
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nix.extraOptions = ''
    trusted-users = root mckahz
  '';

  imports = [
    # Include the results of the hardware scan.
    ./laptop-hardware-configuration.nix
    inputs.dms.nixosModules.greeter
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Fix for virtual box
  boot.kernelParams = [ "kvm.enable_virt_at_load=0" ];

  networking.hostName = "nixos"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Australia/Melbourne";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_AU.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_AU.UTF-8";
    LC_IDENTIFICATION = "en_AU.UTF-8";
    LC_MEASUREMENT = "en_AU.UTF-8";
    LC_MONETARY = "en_AU.UTF-8";
    LC_NAME = "en_AU.UTF-8";
    LC_NUMERIC = "en_AU.UTF-8";
    LC_PAPER = "en_AU.UTF-8";
    LC_TELEPHONE = "en_AU.UTF-8";
    LC_TIME = "en_AU.UTF-8";
  };

  # Niri Window Manager
  programs.niri.enable = true;
  #programs.niri.xwayland.enable = true;

  services.upower.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Define a user account. Don't forget to set a password withS ‘passwd’.
  users.users.mckahz = {
    isNormalUser = true;
    description = "mckahz";
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      #  thunderbird
    ];
  };

  nixpkgs.config = {
    allowUnfree = true;
  };

  # VirtualBox permissions
  virtualisation.virtualbox.host.enable = true;

  # Forces apps to boot with wayland if they can
  environment.sessionVariables = {
    NIXOS_OZONE_WL = 1;
    XDG_CONFIG_HOME = "/home/mckahz/.dotfiles/apps";
  };

  environment.systemPackages = with pkgs; [
    # Ricing
    # quickshell pavucontrol
    nwg-look # To apply themes without editing gtk text files
    btop # System Monitor
    cmatrix # Matrix hacker thingy
    xwayland-satellite # To make discord use xwayland (work)
    papirus-nord # Icon theme
    gruppled-black-cursors
    kmonad # For keyboard macros

    # CLI Utilities
    imagemagick # Edit images
    caligula # Burn ISOs to drives
    ani-cli

    # GUI Applications
    qview # Image viewer
    nautilus # File manager
    krita # Image editor
    libreoffice # Document editor
    # ciscoPacketTracer8
    firefox
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

  systemd.services.kmonad = {
    script = "${pkgs.kmonad}/bin/kmonad ${./keyboard.kbd}";
    wantedBy = [ "multi-user.target" ];
  };

  programs.dank-material-shell.greeter = {
    enable = true;
    compositor.name = "niri";
    configHome = "/home/mckahz";
  };

  programs.bash.promptInit = ''PS1="\n\[$(tput setaf 39)\]@ \w \n\[$(tput sgr0)\]$ "'';

  programs.direnv.enable = true;
  programs.direnv.enableBashIntegration = true;

  programs.nix-ld.enable = true;
  programs.steam.enable = true;

  system.stateVersion = "25.11"; # Did you read the comment?
}
