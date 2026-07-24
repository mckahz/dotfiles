{ ... }: {
  den.aspects.terminal.homeManager =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    {
      home.packages = with pkgs; [ starship ];

      programs = {
        starship = {
          enable = true;
          enableFishIntegration = true;

          settings = {
            add_newline = true;
            scan_timeout = 50;
          };
        };

        fish = {
          enable = true;

          shellAbbrs = {
            zed = "zeditor";
          };

          interactiveShellInit = # builtins.readFile ./fish/init.fish;
            ''
              set fish_greeting # Disable greeting
              ${if config.vim then "fish_vi_key_bindings" else ""}
              starship init fish | source
            '';

          plugins =
            let
              plugin = name: {
                name = name;
                src = pkgs.fishPlugins.${name}.src;
              };
            in
            map plugin [ "z" ];
        };

        kitty = {
          enable = true;
          shellIntegration.enableFishIntegration = true;

          settings = {
            shell = "fish";
            hide_window_decorations = "yes";
            window_padding_width = 8;
            #background_opacity = lib.mkForce 0.8;
          };
        };
      };
    };
}
