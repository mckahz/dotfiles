{ ... }: {
  den.aspects.terminal = {
    nixos = { pkgs, ... }: {
      environment.systemPackages = with pkgs; [ starship ];
    };
    homeManager = { pkgs, ... }: {
      programs = {
        starship = {
          enable = true;
          enableFishIntegration = true;

          settings = {
            add_newline = true;
            scan_timeout = 50;

            # character = {
            #   success_symbol = "[➜](bold green)";
            #   error_symbol = "[➜](bold red)";
            # };

            # package.disabled = true;
          };
        };

        fish = {
          enable = true;

          shellAbbrs = {
            zed = "zeditor .";
          };

          interactiveShellInit = # builtins.readFile ./fish/init.fish;
            ''
              set fish_greeting # Disable greeting
              fish_vi_key_bindings
              starship init fish | source

              # set -g tide_left_prompt_items vi_mode pwd newline character
              # set -g tide_right_prompt_items status cmd_duration jobs node python rustc java php pulumi ruby go gcloud kubectl distrobox toolbox terraform aws nix_shell crystal elixir zig
              # tide configure --auto --style=Rainbow --prompt_colors='True color' --show_time='24-hour format' --rainbow_prompt_separators=Round --powerline_prompt_heads=Round --powerline_prompt_tails=Round --powerline_prompt_style='Two lines, character' --prompt_connection=Solid --powerline_right_prompt_frame=No --prompt_connection_andor_frame_color=Dark --prompt_spacing=Sparse --icons='Few icons' --transient=No
            '';

          plugins =
            let
              plugin = name: {
                name = name;
                src = pkgs.fishPlugins.${name}.src;
              };
            in
            map plugin [
              "z"
              # "tide"
            ];
        };

        kitty = {
          enable = true;
          shellIntegration.enableFishIntegration = true;

          settings = {
            shell = "fish";
            hide_window_decorations = "yes";
            window_padding_width = 8;
            background_opacity = 0.8;
          };
        };
      };
    };
  };
}
