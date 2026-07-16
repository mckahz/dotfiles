{ lib, ... }:
let
  lua = lib.mkLuaInline;
  call = _args: { inherit _args; };
  l = code: [
    (lua code)
    { locked = true; }
  ];
  lr = code: [
    (lua code)
    {
      locked = true;
      repeating = true;
    }
  ];
  moveWindowsAndWorkspaces = (
    builtins.genList (num: num + 1) 9
    |> map toString
    |> map (key: {
      "SUPER + ${key}" = "hl.dsp.focus({workspace = ${key}})";
      "SUPER + CONTROL + ${key}" = "hl.dsp.window.move({workspace = ${key}})";
    })
    |> lib.attrsets.mergeAttrsList
  );
in
{
  den.aspects.keybinds.homeManager = { pkgs, ... }: {
    home.packages = with pkgs; [
      wireplumber
      playerctl
      brightnessctl
    ];
    wayland.windowManager.hyprland.settings.bind =
      {
        "SUPER + Q" = l "hl.dsp.window.close()";
        "SUPER + SHIFT + S" = "hl.dsp.exec_cmd('hyprshot -m region')";
        "SUPER + RETURN" = "hl.dsp.exec_cmd('kitty')";
        "SUPER + O" = "hl.dsp.exec_cmd('echo 1')";
        "SUPER + V" = "hl.dsp.window.float({action='toggle'})";
        "SUPER + F" = "hl.dsp.window.float({action='toggle'})";
        "SUPER + SHIFT + F" = "hl.dsp.window.fullscreen_state({internal = 0, client = 3, action='toggle'})";
        "SUPER + CONTROL + H" = "hl.dsp.window.move({direction = 'left'})";
        "SUPER + CONTROL + J" = "hl.dsp.window.move({direction = 'down'})";
        "SUPER + CONTROL + K" = "hl.dsp.window.move({direction = 'up'})";
        "SUPER + CONTROL + L" = "hl.dsp.window.move({direction = 'right'})";
        "SUPER + H" = "hl.dsp.focus({direction = 'left'})";
        "SUPER + J" = "hl.dsp.focus({direction = 'down'})";
        "SUPER + K" = "hl.dsp.focus({direction = 'up'})";
        "SUPER + L" = "hl.dsp.focus({direction = 'right'})";
        "SUPER + CONTROL + U" = "hl.dsp.workspace.rename({workspace='e', name='e-1'})";
        "SUPER + CONTROL + I" = "hl.dsp.workspace.rename({workspace='e', name='e+1'})";
        "SUPER + U" = "hl.dsp.focus({workspace = 'e-1'})";
        "SUPER + I" = "hl.dsp.focus({workspace = 'e+1'})";
        "SUPER + SPACE" = "hl.dsp.exec_cmd('noctalia-shell ipc call launcher toggle')";
        "SUPER + S" = "hl.dsp.exec_cmd('noctalia-shell ipc call controlCenter toggle')";
        "XF86AudioRaiseVolume" =
          lr "hl.dsp.exec_cmd('${pkgs.wireplumber} set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+')";
        "XF86AudioLowerVolume" =
          lr "hl.dsp.exec_cmd('${pkgs.wireplumber} set-volume @DEFAULT_AUDIO_SINK@ 5%-')";
        "XF86AudioMute" = lr "hl.dsp.exec_cmd('${pkgs.wireplumber} set-mute @DEFAULT_AUDIO_SINK@ toggle')";
        "XF86AudioMicMute" =
          lr "hl.dsp.exec_cmd('${pkgs.wireplumber} set-mute @DEFAULT_AUDIO_SOURCE@ toggle')";
        "XF86MonBrightnessUp" = lr "hl.dsp.exec_cmd('${pkgs.brightnessctl} -e4 -n2 set 5%+')";
        "XF86MonBrightnessDown" = lr "hl.dsp.exec_cmd('${pkgs.brightnessctl} -e4 -n2 set 5%-')";
        "XF86AudioNext" = l "hl.dsp.exec_cmd('${pkgs.playerctl} next')";
        "XF86AudioPause" = l "hl.dsp.exec_cmd('${pkgs.playerctl} play-pause')";
        "XF86AudioPlay" = l "hl.dsp.exec_cmd('${pkgs.playerctl} play-pause')";
        "XF86AudioPrev" = l "hl.dsp.exec_cmd('${pkgs.playerctl} previous')";
      }
      // moveWindowsAndWorkspaces
      |> builtins.mapAttrs (
        input: cmd:
        if builtins.isString cmd then
          [
            input
            (lua cmd)
          ]
        else
          builtins.concatLists [
            [ input ]
            cmd
          ]
      )
      |> builtins.attrValues
      |> map call;
  };
}
