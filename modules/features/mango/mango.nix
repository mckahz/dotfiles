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

    homeManager = {config, ...}: {
      imports = [ ];
      home.file.".config/mango/config.conf".source = config.lib.file.mkOutOfStoreSymlink "/home/mckahz/.dotfiles/modules/features/mango/config.conf";
      home.file.".config/mango/binds.conf".source = config.lib.file.mkOutOfStoreSymlink "/home/mckahz/.dotfiles/modules/features/mango/binds.conf";
    };
  };
}
