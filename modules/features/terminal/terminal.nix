{ ... }: {
  # den.aspects.terminal.nixos = {pkgs, ...}: {
  #   users.defaultUserShell = pkgs.zsh;
  # };

  den.aspects.terminal = {
    nixos = {pkgs, ...}: {
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

    hjem = {
      files.".config/kitty/kitty.conf".source = "/home/mckahz/.dotfiles/modules/features/terminal/kitty/kitty.conf" ;
      files.".vimrc".source = "/home/mckahz/.dotfiles/modules/features/terminal/.vimrc" ;
      files.".zshenv".source = "/home/mckahz/.dotfiles/modules/features/terminal/zsh/.zshenv";
      files.".zshrc".source = "/home/mckahz/.dotfiles/modules/features/terminal/zsh/.zshrc";
      files.".bashrc".source = "/home/mckahz/.dotfiles/modules/features/terminal/.bashrc";
    };
  };
}
