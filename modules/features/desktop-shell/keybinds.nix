{ inputs, lib, ... }:
let
  lua = lib.mkLuaInline;
  call = _args: { inherit _args; };
  r = code: [
    (lua code)
    { repeating = true; }
  ];
  m = code: [
    (lua code)
    { mouse = true; }
  ];
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
  den.aspects.keybinds.homeManager =
    {
      config,
      pkgs,
      host,
      ...
    }:
    {
      home.packages = with pkgs; [
        wireplumber
        playerctl
        brightnessctl
      ];
      wayland.windowManager.hyprland.settings.bind =
        let
          noctalia = lib.getExe inputs.noctalia.packages.${host.system}.default;
          wireplumber = pkgs.wireplumber;
          brightnessctl = lib.getExe pkgs.brightnessctl;
          playerctl = lib.getExe pkgs.playerctl;
        in
        {
          "SUPER + Q" = l "hl.dsp.window.close()";
          "SUPER + RETURN" = "hl.dsp.exec_cmd('kitty')";
          "SUPER + V" = "hl.dsp.window.float({action='toggle'})";
          "SUPER + F" = "hl.dsp.window.fullscreen({mode = 'maximized', action = 'toggle'})";
          # "SUPER + O" = "hl.dsp.exec_cmd('echo 1')";

          # "SUPER + R" = "";
          "SUPER + minus" = r "hl.dsp.window.resize({ x = -100, y = 0, relative = true })";
          "SUPER + equal" = r "hl.dsp.window.resize({ x = 100, y = 0, relative = true })";

          "SUPER + mouse_up" = "hl.dsp.focus({workspace = 'e-1'})";
          "SUPER + mouse_down" = "hl.dsp.focus({workspace = 'e+1'})";
          "SUPER + mouse:272" = m "hl.dsp.window.drag()";
          "SUPER + mouse:273" = m "hl.dsp.window.resize()";

          "SUPER + SHIFT + F" = "hl.dsp.window.fullscreen({mode = 'fullscreen', action = 'toggle'})";
          "SUPER + CONTROL + H" = "hl.dsp.window.move({direction = 'left'})";
          "SUPER + CONTROL + J" = "hl.dsp.window.move({direction = 'down'})";
          "SUPER + CONTROL + K" = "hl.dsp.window.move({direction = 'up'})";
          "SUPER + CONTROL + L" = "hl.dsp.window.move({direction = 'right'})";
          "SUPER + H" = "hl.dsp.focus({direction = 'left'})";
          "SUPER + J" = "hl.dsp.focus({direction = 'down'})";
          "SUPER + K" = "hl.dsp.focus({direction = 'up'})";
          "SUPER + L" = "hl.dsp.focus({direction = 'right'})";
          "SUPER + U" = "hl.dsp.focus({workspace = 'e-1'})";
          "SUPER + I" = "hl.dsp.focus({workspace = 'e+1'})";
          # "SUPER + ," = "hl.dsp.workspace.rename({workspace='e', name='e-1'})";
          # "SUPER + ." = "hl.dsp.workspace.rename({workspace='e', name='e+1'})";

          "SUPER + SHIFT + S" =
            "hl.dsp.exec_cmd('${pkgs.hyprshot} -m region -o ${config.hyprland.screenshots}')";
          "SUPER + SPACE" = "hl.dsp.exec_cmd('${noctalia} msg panel-toggle launcher')";
          "SUPER + Z" = "hl.dsp.exec_cmd('${noctalia} msg session lock')";
          "XF86AudioRaiseVolume" =
            lr "hl.dsp.exec_cmd('${wireplumber} set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+')";
          "XF86AudioLowerVolume" = lr "hl.dsp.exec_cmd('${wireplumber} set-volume @DEFAULT_AUDIO_SINK@ 5%-')";
          "XF86AudioMute" = lr "hl.dsp.exec_cmd('${wireplumber} set-mute @DEFAULT_AUDIO_SINK@ toggle')";
          "XF86AudioMicMute" = lr "hl.dsp.exec_cmd('${wireplumber} set-mute @DEFAULT_AUDIO_SOURCE@ toggle')";
          "XF86MonBrightnessUp" = lr "hl.dsp.exec_cmd('${brightnessctl} -e4 -n2 set 5%+')";
          "XF86MonBrightnessDown" = lr "hl.dsp.exec_cmd('${brightnessctl} -e4 -n2 set 5%-')";
          "XF86AudioNext" = l "hl.dsp.exec_cmd('${playerctl} next')";
          "XF86AudioPause" = l "hl.dsp.exec_cmd('${playerctl} play-pause')";
          "XF86AudioPlay" = l "hl.dsp.exec_cmd('${playerctl} play-pause')";
          "XF86AudioPrev" = l "hl.dsp.exec_cmd('${playerctl} previous')";
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
