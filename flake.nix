{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";
    caelestia-shell = {
      url = "github:caelestia-dots/shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    caelestia-cli = {
      url = "github:caelestia-dots/cli";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # spotatui.url = "github:LargeModGames/spotatui";
  };

  outputs =
    { nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      user = rec {
        name = "mckahz";
        home = "/home/${name}";
        root = "/home/${name}/.dotfiles/nixos";
        config = "${home}/.config";
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

      nvim.${system} = inputs.nvim.${system}.default;

      homeConfigurations.${user.name} = inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home.nix

        ];
        extraSpecialArgs = {
          inherit pkgs;
          inherit user;
          inherit inputs;
          inherit style;
        };
      };
    };
}
