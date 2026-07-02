{
  description = "My Nixvim configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixvim.url = "github:nix-community/nixvim";
    flake-parts.url = "github:hercules-ci/flake-parts";

    caelestia-nvim = {
      url = "github:atdma/caelestia-nvim";
      flake = false;
    };
  };

  outputs =
    { nixvim, flake-parts, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
      ];

      perSystem =
        { system, ... }:
        let
          configuration = nixvim.lib.evalNixvim {
            # Specify the target system.
            inherit system;

            # Import your Nixvim modules
            modules = [ ./default.nix ];

            extraSpecialArgs = { inherit inputs; };
          };
        in
        {
          # Run `nix flake check .` to verify that your config is not broken
          checks.default = configuration.config.build.test;

          # Lets you run `nix run .` to start nixvim
          packages.default = configuration.config.build.package;
        };
    };
}
