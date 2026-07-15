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

      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;

      environment.systemPackages = with pkgs; [
        git
        gh

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
