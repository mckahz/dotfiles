{ inputs, den, ... }:
{
  flake-file.inputs = {
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland.inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.hyprland = {
    includes = [ den.aspects.autologin ];

    nixos = { pkgs, ... }: {
      programs.hyprland.enable = true; # enable Hyprland
      environment.systemPackages = [ pkgs.kitty ];
      environment.sessionVariables.NIXOS_OZONE_WL = "1";
      autologin.session = "${pkgs.hyprland}/bin/start-hyprland";

      hardware.graphics = {
        package = pkgs.mesa;

        # if you also want 32-bit support (e.g for Steam)
        enable32Bit = true;
        package32 = pkgs.pkgsi686Linux.mesa;
      };
    };

    homeManager =
      {
        config,
        pkgs,
        lib,
        host,
        ...
      }:
      let
        lua = lib.generators.mkLuaInline;
        call = _args: { inherit _args; };
        noctalia = lib.getExe inputs.noctalia.packages.${host.system}.default;
      in
      {
        options.hyprland = {
          monitors = lib.mkOption {
            example = [
              {
                output = "eDP-1";
                mode = "1920x1080@60";
                position = "auto";
                scale = 1;
              }
            ];
          };

          lock.enable = lib.mkOption { default = false; };

          screenshots = lib.mkOption {
            default = "${config.home.homeDirectory}/Pictures/Screenshots";
            example = "/home/user/Pictures/Screenshots";
            type = lib.types.str;
          };
        };

        config = {
          home = {
            packages = [
              pkgs.libcamera
              pkgs.hyprshot
            ];

            sessionVariables = {
              ELECTRON_OZONE_PLATFORM_HINT = "wayland"; # does ozone need anything for this?
            };
          };

          wayland.windowManager.hyprland = {
            package = inputs.hyprland.packages.${host.system}.default;
            portalPackage = inputs.hyprland.packages.${host.system}.xdg-desktop-portal-hyprland;

            xwayland.enable = true;
            enable = true;
            systemd.variables = ["--all"];
            systemd.enable = true;
            configType = "lua";

            # plugins = with pkgs.hyprlandPlugins; [ ];
            #extraConfig = ''include("after.lua")'';
            extraLuaFiles =
            let mkFile = file: {
              content =
                if lib.trivial.inPureEvalMode then
                  ./${file}
                else
                  config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/modules/features/desktop-shell/hyprland/${file}";

              autoLoad = true;
            };
            in
            {
              "nix" = { content = ''
                local M = {}

                M.config_home = "${config.home.homeDirectory}/.dotfiles/modules/features/desktop-shell/hyprland"
                M.hyprshot = "${lib.getExe pkgs.hyprshot}"
                M.noctalia = "${lib.getExe inputs.noctalia.packages.${host.system}.default}"
                M.wireplumber = "${pkgs.wireplumber}/bin/wpctl"
                M.brightnessctl = "${lib.getExe pkgs.brightnessctl}"
                M.playerctl = "${lib.getExe pkgs.playerctl}"

                ${config.hyprland.monitors}

                return M
              ''; autoLoad = true; };
              "init" = mkFile "init.lua";
              "monitors" = mkFile "monitors.lua";
              "keybinds" = mkFile "keybinds.lua";
            };
          };
        };
      };
  };
}
