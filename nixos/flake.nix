{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    spotatui = {
      url = "github:LargeModGames/spotatui";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      user = rec {
        name = "mckahz";
        home = "/home/${name}";
        config = "${home}/.dotfiles/apps";
      };
      hosts = [
        "laptop"
        "desktop"
      ];
    in
    {
      nixosConfigurations = nixpkgs.lib.attrsets.mergeAttrsList (
        map (host: {
          ${host} = nixpkgs.lib.nixosSystem {
            inherit system;
            specialArgs = {
              inherit inputs;
              inherit user;
            };
            modules = [
              ./hosts/${host}/configuration.nix
              ./modules/common.nix
            ];
          };
        }) hosts
      );
    };
}
