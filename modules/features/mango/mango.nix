{ den, inputs, ...}: {
  flake-file.inputs.mango = {
    url = "github:mangowm/mango";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.mango = {
    includes = [ den.aspects.autologin ];

    nixos = {pkgs, ...}: {
      imports = [
        inputs.mango.nixosModules.mango
      ];

      autologin.session = "mango";
      programs.mango.enable = true;
    };

    hjem = {
      files.".config/mango/config.conf".source = "/home/mckahz/.dotfiles/modules/features/mango/config.conf";
      files.".config/mango/binds.conf".source = "/home/mckahz/.dotfiles/modules/features/mango/binds.conf";
    };
  };
}
