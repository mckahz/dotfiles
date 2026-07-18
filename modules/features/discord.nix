{ inputs, ... }: {
  flake-file.inputs.nixcord.url = "github:4evy/nixcord";
  #flake-file.inputs.endcord.url = "github:mckahz/endcord-flake";

  den.aspects.discord = {
    homeManager = { pkgs, host, ... }: {
      nixpkgs.config.allowUnfree = true;
      home.packages = [
        pkgs.webcord-vencord
        # TODO: inputs.endcord.${host.system}.packages.default
      ];

      imports = [ inputs.nixcord.homeModules.nixcord ];

      programs.nixcord = {
        enable = true;

        discord.silenceNoModClientWarning = true;

        legcord = {
          enable = true;

          # Optionally bundle Vencord or Equicord (also installs userPlugins)
          # equicord.enable = true;
          vencord.enable = true;

          settings = {
            channel = "stable";
            tray = "dynamic";
            minimizeToTray = true;
            mods = [ "vencord" ];
            doneSetup = true;
          };
        };
      };
    };
  };
}
