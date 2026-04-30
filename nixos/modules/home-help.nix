{
  inputs,
  user,
  lib,
  config,
  ...
}:
{
  options = {
    home = {
      enable = lib.mkEnableOption "enable home manager";
      host = lib.mkOption {
        type = lib.types.str;
        description = "The name of the host device";
      };
    };
  };

  config = lib.mkIf config.home.enable {
    homeConfigurations.${config.home.host} = inputs.home-manager.lib.homeManagerConfiguration {
      extraSpecialArgs = {
        inherit inputs;
        inherit user;
      };
      modules = [
        ./modules/home.nix
      ];
    };

  };
}
