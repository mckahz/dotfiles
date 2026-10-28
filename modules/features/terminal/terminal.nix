{ ... }: {
  # den.aspects.terminal.nixos = {pkgs, ...}: {
  #   users.defaultUserShell = pkgs.zsh;
  # };

  den.aspects.terminal = {
    nixos = { pkgs, ... }: {
      environment.systemPackages = with pkgs; [
        kitty
        starship
        fzf
        bat
        yazi
        less
        man-db
        vim

        git
        bfg-repo-cleaner
        gh

        devenv
        antidote

        # CLI Utilities
        btop # System Monitor
        cmatrix # Matrix hacker thingy
        imagemagick # Edit images
        caligula # Burn ISOs to drives
        ani-cli
      ];

      programs.zsh.enable = true;
      users.defaultUserShell = pkgs.zsh;
    };

    hjem = { osConfig, pkgs, ... }: {
      xdg.config.files."kitty/kitty.conf".source =
        "${osConfig.flake}/modules/features/terminal/kitty/kitty.conf";
      xdg.config.files."kitty/theme.conf".source =
        "${osConfig.flake}/modules/features/terminal/kitty/theme.conf";
      xdg.config.files."starship.toml".source =
        "${osConfig.flake}/modules/features/terminal/starship.toml";

      files.".vimrc".source = "${osConfig.flake}/modules/features/terminal/.vimrc";

      files.".zshrc".source = "${osConfig.flake}/modules/features/terminal/.zshrc";
      files.".zsh_plugins.txt".source = "${osConfig.flake}/modules/features/terminal/.zsh_plugins.txt";
      files.".zsh_plugins_vim.txt".text = ''
        ${if osConfig.vim then "jeffreytse/zsh-vi-mode" else ""}
      '';
      files.".antidote.zsh".text = ''
        source ${pkgs.antidote}/share/antidote/antidote.zsh

        antidote bundle <~/.zsh_plugins.txt >~/.zsh_plugins.zsh
        antidote bundle <~/.zsh_plugins_vim.txt >~/.zsh_plugins_vim.zsh

        source ~/.zsh_plugins.zsh
        source ~/.zsh_plugins_vim.zsh
      '';
    };
  };
}
