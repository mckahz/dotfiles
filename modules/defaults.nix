{ lib, den, ... }:
{
  den.default = {
    homeManager.home.stateVersion = "26.05";
    nixos = { pkgs, ... }: {
      system.stateVersion = "25.11";

      environment.systemPackages = with pkgs; [
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

        git
        gh
        godot_4
      ];

      nixpkgs.config.allowUnfree = true;

      programs.steam.enable = true;

      networking.networkmanager.enable = true;
      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };

  # enable hm by default
  den.schema.user.classes = lib.mkDefault [ "homeManager" ];
}
