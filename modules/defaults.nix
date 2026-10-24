{ lib, den, inputs, ... }:
{
  flake-file.inputs = {
    nix-fast-build.url = "github:Mic92/nix-fast-build";
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify.url = "github:Gerg-L/spicetify-nix";
  };

  perSystem = { pkgs, ... }: {
    packages = den.lib.nh.denPackages { fromFlake = true; } pkgs;
  };

  den.default = {
    includes = [
      den.aspects.keyboard
      den.aspects.terminal
      den.aspects.mango
      den.aspects.noctalia
      den.aspects.editor
      den.aspects.gaming
    ];

    nixos = { config, pkgs, ... }: {
      imports = [./_cachix/cachix.nix inputs.spicetify.nixosModules.default ];

      options = {
        vim = lib.mkOption {
          type = lib.types.bool;
          default = true;
        };

        flake = lib.mkOption {};
      };

      config = {
        system.stateVersion = "25.11";
        hardware.uinput.enable = true;

        boot.loader.systemd-boot.enable = true;
        boot.loader.efi.canTouchEfiVariables = true;

        nixpkgs.config.allowUnfree = true;

        fonts.packages = with pkgs; [jetbrains-mono];
        environment.systemPackages = with pkgs; [
          cachix
          inputs.hjem.packages.${pkgs.stdenv.hostPlatform.system}.hjem
          inputs.nix-fast-build.packages.${pkgs.stdenv.hostPlatform.system}.default
          inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default

          # Random applications
          qview # Image viewer
          krita # Image editor
          nautilus # File explorer
          libreoffice # Document editor
          flamegraph # Profiler visualiser
          transmission_4-qt # Torrent client
          obsidian
          localsend
          (discord.override {
            # withOpenASAR = true; # can do this here too
            withVencord = true;
          })
        ];

        programs.nh = {
          enable = true;
          clean.enable = true;
          clean.extraArgs = "--keep-since 4d --keep 3";
          flake = config.flake;
        };

        programs.spicetify.enable = true;

        # For localsend
        programs.localsend.enable = true;
        programs.localsend.openFirewall = true;
        networking.firewall.enable = true;

        # For torrent client
        services.transmission.settings = {
          download-dir = "${config.services.transmission.home}/Downloads";
        };

        programs.dconf.enable = true;

        networking.networkmanager.enable = true;
        nix.settings = {
          trusted-users = [ "root" "mckahz" "gmang" ];
          warn-dirty = false;
          experimental-features = [
            "nix-command"
            "flakes"
            "pipe-operators"
          ];
        };
      };
    };

  };

  # enable hm by default
  den.schema.user.classes = lib.mkDefault [ "hjem" ];
}
