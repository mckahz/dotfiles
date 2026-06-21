{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri-flake = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spotatui = {
      url = "github:LargeModGames/spotatui";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    utils.url = "github:numtide/flake-utils";

    quickshell = {
      url = "git+https://git.outfoxxed.me/quickshell/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
      hosts = builtins.attrNames (builtins.readDir ./hosts);
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

      homeConfigurations.${user.name} = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        modules = [ ./home.nix ];
        extraSpecialArgs = {
          inherit user;
          inherit inputs;
        };
      };
    };
}
