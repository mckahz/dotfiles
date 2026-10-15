{ lib, den, ... }:
{
  perSystem = { pkgs, ... }: {
    packages = den.lib.nh.denPackages { fromFlake = true; } pkgs;
  };

  den.default = {
    nixos = { config, pkgs, ... }: {
      options = {
        vim = lib.mkOption {
          type = lib.types.bool;
          default = true;
        };
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
          flake = "/home/mckahz/.dotfiles";
        };

        environment.systemPackages = with pkgs; [
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

        nix.settings.warn-dirty = false;

        networking.networkmanager.enable = true;
        nix.settings.experimental-features = [
          "nix-command"
          "flakes"
          "pipe-operators"
        ];
      };
    };

    homeManager = { config, pkgs, ... }: {
      options = {
        outOfStoreIfImpure = lib.mkOption {};

        vim = lib.mkOption {
          type = lib.types.bool;
          default = true;
        };
      };

      config = {
        home.stateVersion = "26.05";

        nix.settings.experimental-features = [
          "nix-command"
          "flakes"
          "pipe-operators"
        ];

        xdg.configHome = "${config.home.homeDirectory}/.config";

        outOfStoreIfImpure = pure: impure:
            if lib.trivial.inPureEvalMode then
              builtins.readFile ./${pure}
            else
              builtins.readFile (config.lib.file.mkOutOfStoreSymlink impure);
      };
    };

  };

  # enable hm by default
  den.schema.user.classes = lib.mkDefault [ "homeManager" ];
}
