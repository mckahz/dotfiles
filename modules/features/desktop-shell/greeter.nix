{ inputs, ... }: {

  flake-file.inputs = {
    noctalia-greeter = {
      url = "github:noctalia-dev/noctalia-greeter";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  den.aspects.greeter = {
    nixos = { pkgs, ... }: {
      imports = [
        inputs.noctalia-greeter.nixosModules.default
      ];

      programs.noctalia-greeter = {
        enable = true;

        # Optional configuration
        greeter-args = "";
        settings = {
          cursor = {
            theme = "Bibata-Modern-Ice";
            size = 24;
            path = "${pkgs.bibata-cursors}/share/icons";
          };
          keyboard = {
            layout = "us";
          };
        };
      };
    };

  };
}
