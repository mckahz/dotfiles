{ ... }: {
  den.aspects.terminal = {
    # nixos = { pkgs, ... }: {
    #   environment.systemPackages = with pkgs; [
    #     procps
    #     fish
    #   ];

    #   programs.bash = {
    #     interactiveShellInit = ''
    #       if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
    #       then
    #         shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
    #         exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
    #       fi
    #     '';
    #   };
    # };

    homeManager = { pkgs, lib, ... }: {
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
            zed = "zeditor .";
          };

          interactiveShellInit = # builtins.readFile ./fish/init.fish;
            ''
              set fish_greeting # Disable greeting
              fish_vi_key_bindings
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
            background_opacity = lib.mkForce 0.8;
          };
        };
      };
    };
  };
}
