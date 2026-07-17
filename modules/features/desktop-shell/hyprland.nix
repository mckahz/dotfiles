{ inputs, den, ... }:
{
  flake-file.inputs = {
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland.inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.hyprland = {
    nixos = { pkgs, ... }: {
      programs.hyprland.enable = true; # enable Hyprland
      environment.systemPackages = [ pkgs.kitty ];
      environment.sessionVariables.NIXOS_OZONE_WL = "1";
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
      in
      {
        home = {
          packages = [
            pkgs.libcamera
            pkgs.hyprshot
            pkgs.hyprpaper
          ];

          sessionVariables = {
            ELECTRON_OZONE_PLATFORM_HINT = "wayland"; # does ozone need anything for this?
          };
        };

        services.hyprpaper = {
          enable = true;
          settings = {
            wallpaper = [
              {
                monitor = "";
                path = "${config.home.homeDirectory}/Pictures/wallpapers/";
              }
            ];
          };
        };

        wayland.windowManager.hyprland = {
          package = inputs.hyprland.packages.${host.system}.default;
          portalPackage = inputs.hyprland.packages.${host.system}.xdg-desktop-portal-hyprland;

          enable = true;
          systemd.enable = true;
          configType = "lua";

          # plugins = with pkgs.hyprlandPlugins; [ ];
        };

        wayland.windowManager.hyprland.settings = {
          config = {
            master = {
              new_status = "master";
              new_on_active = "after";
              orientation = "left";
              smart_resizing = true;
              drop_at_cursor = true;
              mfact = 0.67;
              special_scale_factor = 0.5;
            };

            general = {
              layout = "master";
              gaps_in = 8;
              gaps_out = 16;
              border_size = 2;
            };

            decoration = {
              rounding = 10;
            };

            input = {
              kb_layout = "us";
              numlock_by_default = true;
              touchpad = {
                natural_scroll = true;
              };
            };

            misc = {
              force_default_wallpaper = 0;
              disable_hyprland_logo = true;
            };

          };

          monitor = {
            output = "eDP-1";
            mode = "1920x1080@60";
            position = "0x0";
            scale = 1;
          };

          animation = call [
            {
              leaf = "workspaces";
              enabled = true;
              speed = 5;
              spring = "default";
              style = "slidevert";
            }
          ];
          window_rule = map call [
            [
              {
                match.class = "kitty";
                border_size = 2;
              }
            ]
            [
              {
                # Fix some dragging issues with XWayland
                name = "fix-xwayland-drags";
                match = {
                  class = "^$";
                  title = "^$";
                  xwayland = true;
                  float = true;
                  fullscreen = false;
                  pin = false;
                };

                no_focus = true;
              }
            ]
          ];

          on = call [
            "hyprland.start"
            (lua ''
              function()
                hl.exec_cmd('${lib.getExe inputs.noctalia.packages.${host.system}.default}')
                hl.exec_cmd('${lib.getExe pkgs.hyprpaper}}')
              end
            '')
          ];

          gesture = call [
            {
              fingers = 3;
              direction = "vertical";
              action = "workspace";
            }
          ];
        };
      };
  };
}
