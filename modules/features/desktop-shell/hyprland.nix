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
            default = [
              {
                output = "eDP-1";
                mode = "1920x1080@60";
                position = "0x0";
                scale = 1;
              }
            ];
          };

          lock.enable = lib.mkOption { default = false; };

          masterOrientation = lib.mkOption { default = "left"; };

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
              pkgs.hyprpaper
            ];

            sessionVariables = {
              ELECTRON_OZONE_PLATFORM_HINT = "wayland"; # does ozone need anything for this?
            };
          };

          programs.hyprlock = {
            enable = false;
            settings = {
              general = {
                hide_cursor = false;
                ignore_empty_input = true;
              };

              animations = {
                enabled = true;
                fade_in = {
                  duration = 300;
                  bezier = "easeOutQuint";
                };
                fade_out = {
                  duration = 300;
                  bezier = "easeOutQuint";
                };
              };

              label =
                let
                  h1 = 120;
                  h2 = 80;
                  button = 100;
                in
                [
                  {
                    monitor = "";
                    text = "$TIME";
                    font_size = h1;
                    position = "0, 200";
                    valign = "center";
                    halign = "center";
                  }
                  {
                    monitor = "";
                    text = "Login as $USER";
                    font_size = h2;
                    position = "0, -200";
                    valign = "center";
                    halign = "center";
                  }
                  {
                    monitor = "";
                    text = "Reboot";
                    font_size = button;
                    position = "0, -200";
                    valign = "center";
                    halign = "center";
                  }
                ];
            };
          };

          wayland.windowManager.hyprland = {
            package = inputs.hyprland.packages.${host.system}.default;
            portalPackage = inputs.hyprland.packages.${host.system}.xdg-desktop-portal-hyprland;

            xwayland.enable = true;
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
                orientation = config.hyprland.masterOrientation; # top
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
                disable_splash_rendering = true;
                disable_hyprland_logo = true;
              };

            };

            monitor = map (monitor: call [ monitor ]) config.hyprland.monitors;

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
                {
                  match.class = "pkmncc.exe";
                  fullscreen = true;
                  size = {
                    width = 1440;
                    height = 1080;
                  };
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
                  hl.exec_cmd('${noctalia} -d')
                  ${if config.hyprland.lock.enable then "hl.exec_cmd('${noctalia} msg session lock')" else ""}
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
  };
}
