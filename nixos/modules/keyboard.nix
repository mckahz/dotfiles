{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    keyboard = {
      enable = lib.mkEnableOption "enables keyboard macros with kmonad";
      path = lib.mkOptionType {
        type = lib.types.str;
        description = "The path to the .kbd file used on the device";
      };
    };
  };

  config = lib.mkIf config.keyboard.enable {
    environment.systemPackages = [ pkgs.kmonad ];

    systemd.services.kmonad = {
      script = "${pkgs.kmonad}/bin/kmonad ${builtins.toString ./keyboard.kbd}";
      wantedBy = [ "multi-user.target" ];
    };
  };
}
