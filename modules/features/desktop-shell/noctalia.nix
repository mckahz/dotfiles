{ inputs, ... }: {
  flake-file.inputs = {
    noctalia.url = "github:noctalia-dev/noctalia";
    noctalia.inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.noctalia = { ... }: {
    nixos = { lib, ... }: {
      networking.networkmanager.enable = lib.mkForce true;
      hardware.bluetooth.enable = lib.mkForce true;
      services.power-profiles-daemon.enable = lib.mkForce true;
      services.upower.enable = lib.mkForce true;
    };

    homeManager = { config, ... }: {
      imports = [ inputs.noctalia.homeModules.default ];

      programs.noctalia = {
        enable = true;
        # :p (fromTOML (builtins.readFile ./noctalia-config)
        settings = {
          bar = {
            order = [ "sidebar" ];
            sidebar = {
              background_opacity = 0.74;
              capsule_thickness = 0.62;
              start = [
                "launcher"
                "workspaces"
                "active_window"
                "tray"
                "media"
                "audio_visualizer"
              ];
              center = [
                "screenshot"
                "clock"
                "temp"
                "cpu"
                "ram"
              ];
              end = [
                "network"
                "bluetooth"
                "volume"
                "wallpaper"
                "battery"
                "control-center"
                "session"
              ];
              margin_ends = 0;
              position = "left";
              radius_bottom_left = 0;
              radius_top_left = 0;
              scale = 1.25;
              thickness = 46;
              widget_spacing = 12;
            };
          };
          control_center = {
            sidebar = "full";
            sidebar_section = "full";
          };
          dock = {
            background_opacity = 0.8;
          };
          location = {
            address = "Melbourne, Australia";
          };
          lockscreen_widgets = {
            enabled = false;
            grid = {
              cell_size = 16;
              major_interval = 4;
              visible = true;
            };
            schema_version = 2;
            widget = {
              "lockscreen-login-box@eDP-1" = {
                box_height = 70;
                box_width = 400;
                cx = 960;
                cy = 961;
                output = "eDP-1";
                rotation = 0;
                settings = {
                  background_color = "surface_variant";
                  background_opacity = 0.88;
                  background_radius = 12;
                  center_password_text = false;
                  input_opacity = 1;
                  input_radius = 6;
                  show_caps_lock = true;
                  show_keyboard_layout = true;
                  show_login_button = true;
                  show_password_hint = true;
                };
                type = "login_box";
              };
            };
            widget_order = [ "lockscreen-login-box@eDP-1" ];
          };
          notification = {
            background_opacity = 0.8;
          };
          osd = {
            background_opacity = 0.8;
          };
          settings = { };
          shell = {
            font_family = "DejaVu Sans";
            lang = "en";
            panel = {
              clipboard_position = "auto";
              open_near_click_clipboard = true;
              open_near_click_control_center = true;
              open_near_click_wallpaper = true;
            };
            password_style = "random";
            polkit_agent = true;
            screenshot = {
              confirm_region = true;
              directory = "~/Pictures/Screenshots";
            };
          };
          theme = {
            custom_palette = "stylix";
            mode = "dark";
            source = "custom";
          };
          wallpaper = {
            automation = {
              enabled = false;
              interval_seconds = 1800;
              order = "random";
              recursive = true;
            };
            directory = config.theme.wallpapers;
            # directory_dark = "/home/user/Wallpapers/Dark";
            # directory_light = "/home/user/Wallpapers/Light";
            edge_smoothness = 0.3;
            enabled = true;
            fill_mode = "crop";
            # monitor = {
            #   DP-2 = {
            #     directory = "/home/user/Wallpapers/Vertical";
            #     directory_dark = "/home/user/Wallpapers/Vertical/Dark";
            #     directory_light = "/home/user/Wallpapers/Vertical/Light";
            #     enabled = false;
            #     fill_color = "#202020";
            #   };
            # };
            # per_monitor_directories = false;
            transition = [
              "fade"
              "wipe"
              "disc"
              "stripes"
              "zoom"
              "honeycomb"
            ];
            transition_duration = 1500;
            transition_on_startup = false;
          };
          widget = {
            active_window = {
              icon_size = 22;
            };
            battery = {
              show_label = false;
            };
            brightness = {
              show_label = false;
            };
            clock = {
              anchor = true;
              capsule = true;
              capsule_fill = "primary";
              capsule_padding = 11;
              color = "on_primary";
              timezone = "Australia/Melbourne";
              vertical_format = "{:%H\\n%M}";
            };
            cpu = {
              color = "secondary";
              icon_color = "on_surface";
              show_label = false;
            };
            network = {
              show_label = false;
            };
            ram = {
              color = "secondary";
              icon_color = "on_surface";
              show_label = false;
              stat = "ram_pct";
            };
            sysmon = {
              icon_color = "secondary";
              show_label = false;
            };
            temp = {
              color = "secondary";
              icon_color = "on_surface";
              show_label = false;
            };
            volume = {
              show_label = false;
            };
            workspaces = {
              scale = 1.25;
            };
          };
        };
      };
    };
  };

}
