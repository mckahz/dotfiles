{ inputs, den, ... }:
{
  den.aspects.keyboard = {
    inputs.keyd.url = "github:rvaiya/keyd";

    nixos =
      {
        pkgs,
        lib,
        config,
        ...
      }:
      {
        options.keyboard.device = lib.mkOption {
          example = "/dev/input/by-id/xxxxxxxxxxx-kbd";
          description = "Path to your keyboard device";
          type = lib.types.path;
        };

        config = {
          services.keyd.enable = false;

          users.groups.uinput = { };

          environment.systemPackages = [ pkgs.kanata ];

          systemd.services.kanata-myKeyboard.serviceConfig = {
            SupplementaryGroups = [
              "input"
              "uinput"
            ];
          };

          services.kanata = {
            enable = true;
            keyboards = {
              myKeyboard = {
                devices = [ config.keyboard.device ];
                config = ''
                  (defsrc
                    esc f1   f2   f3   f4   f5   f6   f7   f8   f9  f10  f11  f12 ins del
                    grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
                    tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
                    caps a    s    d    f    g    h    j    k    l    ;    '         ret
                    lsft z    x    c    v    b    n    m    ,    .    / rsft
                    lctl lmet lalt           spc            ralt rmet rctl
                  )

                  (defalias vim (tap-hold 200 200 esc lctl))

                  (deflayer my-keyboard
                    caps f1   f2   f3   f4   f5   f6   f7   f8   f9  f10  f11  f12 ins del
                    grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
                    tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
                    @vim a    s    d    f    g    h    j    k    l    ;    '         ret
                    lsft z    x    c    v    b    n    m    ,    .    / rsft
                    lctl lmet lalt           spc            ralt rmet rctl
                  )
                '';
              };
            };
          };

        };
      };
  };
}
