{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      quickshell,
      utils,
    }:
    utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
        defaultPackages = [
          quickshell.packages.${system}.default
        ];
      in
      {
        defaultPackage = defaultPackages;
        devShell = pkgs.mkShell {
          buildInputs = [
            defaultPackages
          ];
        };
      }
    );
}
