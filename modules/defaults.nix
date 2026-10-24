{ lib, den, inputs, ... }:
{
  flake-file.inputs.nix-fast-build = {
    url = "github:Mic92/nix-fast-build";
  };

  perSystem = { pkgs, ... }: {
    packages = den.lib.nh.denPackages { fromFlake = true; } pkgs;
  };

  den.default = {
    nixos = { config, pkgs, ... }: {
      imports = [./_cachix/cachix.nix ];

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

        programs.nh = {
          enable = true;
          clean.enable = true;
          clean.extraArgs = "--keep-since 4d --keep 3";
          flake = config.flake;
        };

        environment.systemPackages = with pkgs; [
          cachix
          inputs.hjem.packages.${pkgs.stdenv.hostPlatform.system}.hjem
          inputs.nix-fast-build.packages.${pkgs.stdenv.hostPlatform.system}.default

          # GUI Applications
          qview # Image viewer
          krita # Image editor
          nautilus
          libreoffice # Document editor
          obsidian

          flamegraph
        ];

        programs.dconf.enable = true;

        nixpkgs.config.allowUnfree = true;

        networking.networkmanager.enable = true;
        nix.settings = {
          trusted-users = [ "root" "mckahz" ];
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
