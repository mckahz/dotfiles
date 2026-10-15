{ ... }: {
  # den.aspects.terminal.nixos = {pkgs, ...}: {
  #   users.defaultUserShell = pkgs.zsh;
  # };

  den.aspects.terminal.homeManager =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    {
      home.packages = with pkgs; [
        # starship
        fzf
        zsh
        bat
        yazi
        less
        man-db
        vim

        git
        bfg-repo-cleaner
        gh

        devenv

        # CLI Utilities
        btop # System Monitor
        cmatrix # Matrix hacker thingy
        imagemagick # Edit images
        caligula # Burn ISOs to drives
        ani-cli

      ];

      programs =
        {
          vim = {
            extraConfig = config.outOfStoreIfImpure ./.vimrc "/home/mckahz/.dotfiles/modules/features/desktop-shell/terminal/.vimrc" ;
          };

          zsh = {
            enable = true;
            envExtra = config.outOfStoreIfImpure ./zsh/.zshenv "/home/mckahz/.dotfiles/modules/features/desktop-shell/terminal/zsh/.zshenv" ;
          };

          starship = {
            enable = true;
            enableZshIntegration = true;

            settings = {
              add_newline = true;
              scan_timeout = 50;
            };
          };

          kitty = {
            enable = true;
            shellIntegration.enableZshIntegration = true;
            keybindings = {
              "ctrl+v" = "paste_from_clipboard";
              "ctrl+-" = "change_font_size all -1.0";
              "ctrl+=" = "change_font_size all +1.0";
              "ctrl+0" = "change_font_size all 0";
            };

            settings = {
              confirm_os_window_close = 0;
              shell = "zsh";
              hide_window_decorations = "yes";
              window_padding_width = 8;
              copy_on_select = true;
              strip_trailing_spaces = "smart";
              scrollback_fill_enlarged_window = "yes";
              auto_reload_config = 0;

              cursor_shape = "block";
              cursor_blink_interval = 1;
              cursor_stop_blinking_after = 40.0;
              cursor_trail = 1;
              cursor_trail_start_threshold = 2;

              #background_opacity = lib.mkForce 0.8;
            };

            extraConfig = ''
              color8 #777777
            '';
          };
        };
    };
}
