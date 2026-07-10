{ inputs, ... }: {
  flake-file.inputs.nixcord.url = "github:4evy/nixcord";

  den.aspects.discord = {
    nixos = { pkgs, ... }: {
      environment.systemPackages = with pkgs; [
        xwayland-satellite # To make discord use xwayland (work)
        discord
      ];
    };
    homeManager = { pkgs, ... }: {
      imports = [ inputs.nixcord.homeModules.nixcord ];
      programs.nixcord.legcord = {
        enable = true;
        # config = { };
      };
    };
  };
}
