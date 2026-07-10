_: {
  den.aspects.browser = {
    nixos = { pkgs, ... }: {
      environment.systemPackages = [ pkgs.firefox ];
    };

    homeManager = { ... }: {
      programs.firefox = {
        enable = true;
        profiles.me = {
          settings = {
            "ui.systemUsesDarkTheme" = 1;
            "layout.css.prefers-color-scheme.content-override" = 0;
            "browser.in-content.dark-mode" = true;
          };
        };
      };
    };
  };
}
