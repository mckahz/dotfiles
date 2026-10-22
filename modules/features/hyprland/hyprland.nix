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
        home = {
          packages = with pkgs; [
            libcamera
            hyprshot
            nwg-displays
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
              config.outOfStoreIfImpure ./${file} "/home/mckahz/.dotfiles/modules/features/hyprland/${file}";

            autoLoad = true;
          };
          in
          {
            "nix" = { content = ''
              local M = {}

              M.config_home = "${config.home.homeDirectory}/.dotfiles/modules/features/hyprland"
              M.hyprshot = "${lib.getExe pkgs.hyprshot}"
              M.noctalia = "${lib.getExe inputs.noctalia.packages.${host.system}.default}"
              M.wireplumber = "${pkgs.wireplumber}/bin/wpctl"
              M.brightnessctl = "${lib.getExe pkgs.brightnessctl}"
              M.playerctl = "${lib.getExe pkgs.playerctl}"

              return M
            ''; autoLoad = true; };
            "init" = mkFile "init.lua";
            "keybinds" = mkFile "keybinds.lua";
          };
        };
      };
  };
}
