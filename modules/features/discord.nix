{ inputs, ... }: {
  flake-file.inputs.nixcord.url = "github:4evy/nixcord";
  #flake-file.inputs.endcord.url = "github:mckahz/endcord-flake";

  den.aspects.discord = {
    homeManager =
      {
        config,
        pkgs,
        ...
      }:
      {
        nixpkgs.config.allowUnfree = true;
        home.packages = [
          pkgs.webcord-vencord
          # TODO, discord tui: inputs.endcord.${host.system}.packages.default
        ];

        imports = [ inputs.nixcord.homeModules.nixcord ];

        programs.nixcord = {
          enable = true;
          user = config.home.username;

          vesktop.enable = true;
          discord = {
            vencord.enable = true; # Standard Vencord
          };

        };
      };
  };
}
