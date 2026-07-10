{ pkgs, user, ... }: {
  home.packages = [pkgs.firefox];
  programs.firefox = {
    enable = true;

    profiles.${user.name} = {
      settings = {
        "ui.systemUsesDarkTheme" = 1;
        "layout.css.prefers-color-scheme.content-override" = 0;
        "browser.in-content.dark-mode" = true;
      };
    };
  };
}
