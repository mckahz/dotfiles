{ lib, ... }:
let
  lua = lib.generators.mkLuaInline;
  call = _args: { inherit _args; };

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
        (lua "hl.dsp.exec_cmd('caelestia shell drawers toggle launcher')")
      ]
      [
        "SUPER + O"
        (lua "hl.dsp.exec_cmd('caelestia shell drawers toggle dashboard')")
      ]
      [
        "SUPER + Q"
        (lua "hl.dsp.window.close()")
        { locked = true; }
      ] # idk what this does
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
in
{
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [ ];
      wallpaper = [
        {
          monitor = "";
          path = "~/Pictures/Wallpapers";
          fit_mode = "fill";
          timeout = 120;
          order = "random";
        }
      ];
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false; # Conflict with UWSM
    configType = "lua";
    settings = {
      mod = {
        _var = "SUPER";
      };

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

      inherit bind;

      inherit gesture;

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
            hl.exec_cmd('caelestia shell -d')
            hl.exec_cmd('systemctl --user enable --now hyprpaper.service')
          end
        '')
      ];
    };

    package = null;
    portalPackage = null;
  };
}
