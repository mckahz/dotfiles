{ inputs, den, ... }:
{
  flake-file.inputs = {
    noctalia.url = "github:noctalia-dev/noctalia/legacy-v4";
    noctalia.inputs.nixpkgs.follows = "nixpkgs";

    hyprland.url = "github:hyprwm/Hyprland";
    hyprland.inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.hyprland = {
    includes = [ ];
    nixos = { host, ... }: {
      environment.systemPackages = [ inputs.hyprland.packages.${host.system}.default ];

      programs = {
        uwsm = {
          enable = true;
          # You must configure the waylandCompositors suboptions so that UWSM knows which compositors to manage.
          waylandCompositors = {
            hyprland = {
              prettyName = "Hyprland";
              comment = "Hyprland compositor managed by UWSM";
              binPath = "${inputs.hyprland.packages.${host.system}.default}/bin/start-hyprland";
            };
          };
        };

        hyprland = {
          enable = true;
          withUWSM = true;
        };
      };
    };
    homeManager =
      {
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
        imports = [
          inputs.noctalia.homeModules.default
        ];

        xdg.configFile."hypr/hyprland.lua".force = true;
        xdg.configFile."noctalia/settings.json".force = true;

        home = {
          packages = with pkgs; [
            hyprcursor
            bibata-cursors
          ];

          sessionVariables = {
            ELECTRON_OZONE_PLATFORM_HINT = "wayland";

            XCURSOR_THEME = "Bibata-Modern-Classic";
            XCURSOR_SIZE = lib.mkForce "24";
            HYPRCURSOR_THEME = "Bibata-Modern-Classic";
            HYPRCURSOR_SIZE = lib.mkForce "24";
          };

          pointerCursor = {
            enable = true;
            gtk.enable = true;
            x11.enable = true;
            package = pkgs.bibata-cursors;
            name = "Bibata-Modern-Classic";
            size = 24;
            hyprcursor = {
              enable = true;
              size = 24;
            };
          };
        };

        gtk = {
          enable = true;
          cursorTheme = {
            name = "Bibata-Modern-Classic";
            size = 24;
          };
        };

        dconf.settings = {
          "org/gnome/desktop/interface" = {
            cursor-theme = "Bibata-Modern-Classic";
          };
        };

        programs = {
          noctalia-shell = {
            enable = true;
            settings = (builtins.fromJSON (builtins.readFile ./noctalia.json)).settings;

          };

          kitty.extraConfig = ''
            include themes/noctalia.conf
          '';
        };

        wayland.windowManager.hyprland = {
          package = inputs.hyprland.packages.${host.system}.default;
          portalPackage = inputs.hyprland.packages.${host.system}.xdg-desktop-portal-hyprland;

          enable = true;
          systemd.enable = false;
          configType = "lua";

          # plugins = with pkgs.hyprlandPlugins; [ ];

          settings = {
            config = {
              master = {
                new_status = "master";
                new_on_active = "after";
                orientation = "left";
                smart_resizing = true;
                drop_at_cursor = true;
                mfact = 0.67;
                special_scale_factor = 0.8;
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
                  hl.exec_cmd('noctalia-shell -d')

                  -- hl.exec_cmd('systemctl --user enable --now wallpaper.service')
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

            bind = map call (
              [
                [
                  "SUPER + RETURN"
                  (lua "hl.dsp.exec_cmd('kitty')")
                ]
                [
                  "SUPER + SPACE"
                  (lua "hl.dsp.exec_cmd('echo 1')")
                ]
                [
                  "SUPER + O"
                  (lua "hl.dsp.exec_cmd('echo 1')")
                ]
                [
                  "SUPER + Q"
                  (lua "hl.dsp.window.close()")
                  { locked = true; }
                ]
                [
                  "SUPER + V"
                  (lua "hl.dsp.window.float({action='toggle'})")
                ]
                [
                  "SUPER + F"
                  (lua "hl.dsp.window.float({action='toggle'})")
                ]
                [
                  "SUPER + SHIFT + F"
                  (lua "hl.dsp.window.fullscreen_state({internal = 0, client = 3, action='toggle'})")
                ]
                [
                  "SUPER + CONTROL + H"
                  (lua "hl.dsp.window.move({direction = 'left'})")
                ]
                [
                  "SUPER + CONTROL + J"
                  (lua "hl.dsp.window.move({direction = 'down'})")
                ]
                [
                  "SUPER + CONTROL + K"
                  (lua "hl.dsp.window.move({direction = 'up'})")
                ]
                [
                  "SUPER + CONTROL + L"
                  (lua "hl.dsp.window.move({direction = 'right'})")
                ]
                [
                  "SUPER + H"
                  (lua "hl.dsp.focus({direction = 'left'})")
                ]
                [
                  "SUPER + J"
                  (lua "hl.dsp.focus({direction = 'down'})")
                ]
                [
                  "SUPER + K"
                  (lua "hl.dsp.focus({direction = 'up'})")
                ]
                [
                  "SUPER + L"
                  (lua "hl.dsp.focus({direction = 'right'})")
                ]
                [
                  "SUPER + CONTROL + U"
                  (lua "hl.dsp.workspace.rename({workspace='e', name='e-1'})")
                ]
                [
                  "SUPER + CONTROL + I"
                  (lua "hl.dsp.workspace.rename({workspace='e', name='e+1'})")
                ]
                [
                  "SUPER + U"
                  (lua "hl.dsp.focus({workspace = 'e-1'})")
                ]
                [
                  "SUPER + I"
                  (lua "hl.dsp.focus({workspace = 'e+1'})")
                ]
                [
                  "SUPER + SPACE"
                  (lua "hl.dsp.exec_cmd('noctalia-shell ipc call launcher toggle')")
                ]
                [
                  "SUPER + S"
                  (lua "hl.dsp.exec_cmd('noctalia-shell ipc call controlCenter toggle')")
                ]
              ]
              ++ builtins.concatLists (
                builtins.genList (
                  num:
                  let
                    key = toString (num + 1);
                  in
                  [
                    [
                      "SUPER + ${key}"
                      (lua "hl.dsp.focus({workspace = ${key}})")
                    ]
                    [
                      "SUPER + CONTROL + ${key}"
                      (lua "hl.dsp.window.move({workspace = ${key}})")
                    ]
                  ]
                ) 9
              )
            );
          };
        };

      };
  };
}
