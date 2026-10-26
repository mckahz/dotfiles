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

    hjem = { osConfig, ... }: {
      xdg.config.files."kitty/kitty.conf".source =
        "${osConfig.flake}/modules/features/terminal/kitty/kitty.conf";
      xdg.config.files."kitty/theme.conf".source =
        "${osConfig.flake}/modules/features/terminal/kitty/theme.conf";
      xdg.config.files."starship.toml".source =
        "${osConfig.flake}/modules/features/terminal/starship.toml";
      files.".vimrc".source = "${osConfig.flake}/modules/features/terminal/.vimrc";
      files.".zshenv".source = "${osConfig.flake}/modules/features/terminal/zsh/.zshenv";
      files.".zshenv-nix".text = "export ZDOTDIR=\"${osConfig.flake}/modules/features/terminal/zsh\"";
      files.".zshrc-vim".text =
        if osConfig.vim then
          ''
            zplug zsh-vi-mode/zsh-vi-mode.plugin.zsh
          ''
        else
          "";
      files.".zshrc".source = "${osConfig.flake}/modules/features/terminal/zsh/.zshrc";
      files.".bashrc".source = "${osConfig.flake}/modules/features/terminal/.bashrc";
    };
  };
}
