{ lib, den, ... }:
{
  perSystem = { pkgs, ... }: {
    packages = den.lib.nh.denPackages { fromFlake = true; } pkgs;
  };

  den.default = {
    homeManager = { pkgs, ... }: {
      home.stateVersion = "26.05";

      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
        "pipe-operators"
      ];
    };

    nixos = { pkgs, ... }: {
      system.stateVersion = "25.11";
      hardware.uinput.enable = true;

      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;

      environment.systemPackages = with pkgs; [
        git
        gh
        localsend

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

        zoom-us

        steam

        godot_4
      ];

      programs.steam.enable = true;

      nixpkgs.config.allowUnfree = true;

      nix.settings.warn-dirty = false;

      networking.networkmanager.enable = true;
      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
        "pipe-operators"
      ];
    };
  };

  # enable hm by default
  den.schema.user.classes = lib.mkDefault [ "homeManager" ];
}
