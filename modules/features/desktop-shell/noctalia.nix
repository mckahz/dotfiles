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
      };

      # :p fromTOML (builtins.readFile ./noctalia-config)
      programs.noctalia.settings = {
        active_window = {
          icon_size = 22;
        };
        bar = {
          order = [ "sidebar" ];
          sidebar = {
            background_opacity = 0.74;
            capsule_thickness = 0.62;
            center = [
              "screenshot"
              "clock"
              "cpu"
              "temp"
              "ram"
            ];
            end = [
              "tray"
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
            start = [
              "launcher"
              "workspaces"
              "active_window"
              "media"
              "audio_visualizer"
            ];
            thickness = 46;
            widget_spacing = 12;
          };
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
          vertical_format = "{:%I\\n%M\\n%p}";
        };
        control_center = {
          sidebar = "full";
          sidebar_section = "full";
        };
        cpu = {
          color = "secondary";
          icon_color = "on_surface";
          show_label = false;
        };
        dock = {
          background_opacity = 0.8;
        };
        location = {
          address = "Melbourne, Australia";
        };
        lockscreen_widgets = {
          enabled = true;
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
              cy = 956;
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
            lockscreen-widget-0000000000000001 = {
              box_height = 80;
              box_width = 192;
              cx = 111;
              cy = 751;
              output = "eDP-1";
              rotation = 0;
              settings = {
                background = true;
                background_color = "surface";
                background_opacity = 0.8;
                background_padding = 10;
                background_radius = 12;
                center_text = false;
                circle = true;
                clock_style = "digital";
                color = "on_surface";
                font_family = "";
                format = "{:%H:%M}";
                shadow = true;
                timezone = "Australia/Melbourne";
              };
              type = "clock";
            };
            lockscreen-widget-0000000000000002 = {
              box_height = 416;
              box_width = 1920;
              cx = 960;
              cy = 0;
              output = "eDP-1";
              rotation = 0;
              settings = {
                background = false;
                bands = 32;
                show_when_idle = true;
              };
              type = "audio_visualizer";
            };
            lockscreen-widget-0000000000000003 = {
              box_height = 0;
              box_width = 0;
              cx = 1741;
              cy = 994;
              output = "eDP-1";
              rotation = 0;
              type = "media_player";
            };
            lockscreen-widget-0000000000000004 = {
              box_height = 144;
              box_width = 192;
              cx = 109;
              cy = 993;
              output = "eDP-1";
              rotation = 0;
              settings = {
                background = true;
                stat = "cpu_usage";
                stat2 = "cpu_temp";
              };
              type = "sysmon";
            };
            lockscreen-widget-0000000000000005 = {
              box_height = 96;
              box_width = 192;
              cx = 111;
              cy = 856;
              output = "eDP-1";
              rotation = 0;
              settings = {
                background = true;
                background_color = "surface";
                background_opacity = 0.8;
                background_padding = 10;
                background_radius = 12;
                color = "on_surface";
                font_family = "";
                forecast_days = 3;
                shadow = true;
                show_forecast = false;
              };
              type = "weather";
            };
          };
          widget_order = [
            "lockscreen-widget-0000000000000002"
            "lockscreen-login-box@eDP-1"
            "lockscreen-widget-0000000000000001"
            "lockscreen-widget-0000000000000003"
            "lockscreen-widget-0000000000000004"
            "lockscreen-widget-0000000000000005"
          ];
        };
        network = {
          show_label = false;
        };
        notification = {
          background_opacity = 0.8;
        };
        osd = {
          background_opacity = 0.8;
        };
        plugins = {
          enabled = [ ];
        };
        ram = {
          color = "secondary";
          icon_color = "on_surface";
          show_label = false;
          stat = "ram_pct";
        };
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
        sysmon = {
          icon_color = "secondary";
          show_label = false;
        };
        temp = {
          color = "secondary";
          icon_color = "on_surface";
          show_label = false;
        };
        theme = {
          builtin = "Noctalia";
          custom_palette = "stylix";
          source = "custom";
          wallpaper_scheme = "m3-content";
        };
        volume = {
          show_label = false;
        };
        wallpaper = {
          directory = "${config.home.homeDirectory}/Pictures/wallpapers";
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
        workspaces = {
          scale = 1.25;
        };
      };
    };
  };
}
