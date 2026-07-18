{ inputs, ... }: {
  flake-file.inputs = {
    nix-firefox-addons.url = "github:osipog/nix-firefox-addons";

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  den.aspects.browser = {
    homeManager = { pkgs, ... }: {
      nixpkgs.overlays = [ inputs.nix-firefox-addons.overlays.default ];

      imports = [
        inputs.zen-browser.homeModules.beta
        # or inputs.zen-browser.homeModules.twilight
        # or inputs.zen-browser.homeModules.twilight-official
      ];

      programs.zen-browser = {
        enable = true;
        setAsDefaultBrowser = true;
        profiles.default = {
          id = 0;
          name = "default";
          isDefault = true;
          settings = {
            "browser.startup.homepage" = "https://duckduckgo.com";
            "browser.search.defaultenginename" = "ddg";
            "browser.search.order.1" = "ddg";
          };
          search = {
            force = true;
            default = "ddg";
            order = [
              "ddg"
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
              "ddg" = {
                urls = [
                  { template = "https://duckduckgo.com/?ia=web&origin=funnel_home_website&t=h_&q={searchTerms}"; }
                ];
                icon = "https://duckduckgo.com/favicon.png";
              };
              "bing".metaData.hidden = true;
              "google".metaData.alias = "@g"; # builtin engines only support specifying one additional alias
            };
          };

          extensions.packages = with pkgs.firefoxAddons; [
            ublock-origin
            lastpass-password-manager
            darkreader
            youtube-shorts-block
            proton-vpn
          ];
        };
      };
    };
  };
}
