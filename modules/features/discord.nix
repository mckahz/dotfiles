{ inputs, ... }: {
  flake-file.inputs.nixcord.url = "github:4evy/nixcord";

  den.aspects.discord = {
    homeManager = { pkgs, ... }: {
      nixpkgs.config.allowUnfree = true;

      imports = [ inputs.nixcord.homeModules.nixcord ];

      programs.nixcord = {
        enable = true;

        discord.silenceNoModClientWarning = true;

        legcord = {
          enable = true;

          # Optionally bundle Vencord or Equicord (also installs userPlugins)
          equicord.enable = true;

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
