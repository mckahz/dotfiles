{ inputs, den, ... }:
{
  flake-file.inputs = {
    # noctalia.url = "github:noctalia-dev/noctalia";
    # noctalia.inputs.nixpkgs.follows = "nixpkgs";

    noctalia-shell.url = "github:noctalia-dev/noctalia/legacy-v4";
    noctalia-shell.inputs.nixpkgs.follows = "nixpkgs";

    hyprland.url = "github:hyprwm/Hyprland";
    hyprland.inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.hyprland = {
    includes = [
      den.aspects.keybinds
    ];

    nixos = { pkgs, host, ... }: {
      nix.settings = {
        substituters = [ "https://hyprland.cachix.org" ];
        trusted-substituters = [ "https://hyprland.cachix.org" ];
        trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
        # Required so non-root users are allowed to use the above substituter/keys.
        # Use @wheel for all sudo users, or list your username explicitly.
        trusted-users = [
          "root"
          "@wheel"
        ];
      };

      environment.systemPackages = [
        inputs.hyprland.packages.${host.system}.default
        pkgs.libcamera
      ];

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
          inputs.noctalia-shell.homeModules.default
          # inputs.noctalia.homeModules.default
        ];

        home.packages = [
          pkgs.hyprshot
        ];

        xdg.configFile."hypr/hyprland.lua".force = true;
        xdg.configFile."noctalia/settings.json".force = true;
        xdg.configFile."noctalia/colors.json".force = true;

        programs = {
          noctalia-shell = {
            enable = true;
            settings = (builtins.fromJSON (builtins.readFile ./noctalia.json)).settings;

          };

          # noctalia = {
          #   enable = true;
          #   settings = (fromTOML (builtins.readFile ./noctalia.toml)).settings;
          # };

          kitty.extraConfig = ''
            include themes/noctalia.conf
          '';
        };

        wayland.windowManager.hyprland = {
          package = inputs.hyprland.packages.${host.system}.default;
          portalPackage = inputs.hyprland.packages.${host.system}.xdg-desktop-portal-hyprland;

          enable = true;
          systemd.enable = false; # conflicts with uwsm
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
                  -- hl.exec_cmd('noctalia -d')

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
          };
        };

      };
  };
}
