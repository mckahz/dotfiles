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
      let read = file:
                if lib.trivial.inPureEvalMode then
                  file
                else
                    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/modules/features/desktop-shell/terminal/zsh/.zshenv"
                    |> builtins.readFile;
                    in
       {
         vim = {
          extraConfig = read ./.vimrc;
         };
         zsh = {
           enable = true;
           envExtra = read ./zsh/.zshenv;
         };

         starship = {
           enable = false;
           # enableFishIntegration = true;
           enableZshIntegration = true;

           settings = {
             add_newline = true;
             scan_timeout = 50;
           };
         };

         fish = {
           enable = false;

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
           #shellIntegration.enableFishIntegration = true;
           shellIntegration.enableZshIntegration = true;

           settings = {
             shell = "zsh";
             hide_window_decorations = "yes";
             window_padding_width = 8;
             #background_opacity = lib.mkForce 0.8;
           };
         };
       };
    };
}
