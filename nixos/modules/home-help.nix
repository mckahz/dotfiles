{
  inputs,
  user,
  lib,
  config,
  pkgs,
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

  };
}
