{ inputs, ... }: {
  flake-file.inputs = {
    nix-firefox-addons.url = "github:osipog/nix-firefox-addons";
  };

  den.aspects.browser = {
    nixos = { pkgs, ... }: {
      environment.systemPackages = [ pkgs.firefox ];

    };

    homeManager = { pkgs, ... }: {
      nixpkgs.overlays = [ inputs.nix-firefox-addons.overlays.default ];

      home.packages = [
        pkgs.pywalfox-native
      ];

      programs.pywal.enable = true;
      programs.pywal.package = pkgs.pywalfox-native;
      programs.firefox = {
        enable = true;

        nativeMessagingHosts = [
          pkgs.pywalfox-native # Exposes the pywalfox manifest to Firefox
        ];

        profiles.default = {
          id = 0;
          name = "default";
          isDefault = true;
          settings = {
            "browser.startup.homepage" = "https://searx.aicampground.com";
            "browser.search.defaultenginename" = "Searx";
            "browser.search.order.1" = "Searx";
          };
          search = {
            force = true;
            default = "Searx";
            order = [
              "Searx"
              "google"
            ];
            engines = {
              "Nix Packages" = {
                urls = [
                  {
                    template = "https://search.nixos.org/packages";
                    params = [
                      {
                        name = "type";
                        value = "packages";
                      }
                      {
                        name = "query";
                        value = "{searchTerms}";
                      }
                    ];
                  }
                ];
                icon = "''${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                definedAliases = [ "@np" ];
              };
              "NixOS Wiki" = {
                urls = [ { template = "https://nixos.wiki/index.php?search={searchTerms}"; } ];
                icon = "https://nixos.wiki/favicon.png";
                updateInterval = 24 * 60 * 60 * 1000; # every day
                definedAliases = [ "@nw" ];
              };
              "Searx" = {
                urls = [ { template = "https://searx.aicampground.com/?q={searchTerms}"; } ];
                icon = "https://nixos.wiki/favicon.png";
                updateInterval = 24 * 60 * 60 * 1000; # every day
                definedAliases = [ "@searx" ];
              };
              "bing".metaData.hidden = true;
              "google".metaData.alias = "@g"; # builtin engines only support specifying one additional alias
            };
          };

          settings = {
            ui.systemUsesDarkTheme = 1;
            layout.css.prefers-color-scheme.content-override = 0;
            browser.in-content.dark-mode = true;
          };

          extensions.packages = with pkgs.firefoxAddons; [
            ublock-origin
            lastpass-password-manager
            darkreader
            youtube-shorts-block
            proton-vpn
            pywalfox
          ];
        };
      };
    };
  };
}
