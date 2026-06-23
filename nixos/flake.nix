{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    caelestia-shell = {
      url = "github:caelestia-dots/shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dms = {
      url = "github:AvengeMedia/DankMaterialShell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    matugen = {
      url = "github:InioX/Matugen";
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
      style = {
        cornerRadius = 10.0;
      };
      hosts = builtins.attrNames (builtins.readDir ./hosts);
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations = nixpkgs.lib.attrsets.mergeAttrsList (
        map (host: {
          ${host} = nixpkgs.lib.nixosSystem {
            inherit system;
            specialArgs = {
              inherit inputs;
              inherit user;
              inherit style;
            };
            modules = [
              ./hosts/${host}/configuration.nix
              ./modules/common.nix
              inputs.home-manager.nixosModules.home-manager
            ];
          };
        }) hosts
      );

      homeConfigurations.${user.name} = inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home.nix
        ];
        extraSpecialArgs = {
          inherit pkgs;
          inherit system;
          inherit user;
          inherit inputs;
          inherit style;
        };
      };
    };
}
