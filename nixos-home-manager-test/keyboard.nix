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
      path = lib.mkOption {
        type = lib.types.path;
        description = "The path to the .kbd file used on the device";
      };
    };
  };

  config = lib.mkIf config.keyboard.enable {
    environment.systemPackages = [ pkgs.kmonad ];

    systemd.services.kmonad = {
      script =
        let
          cmd = "${pkgs.kmonad}/bin/kmonad ${builtins.toString config.keyboard.path}";
        in
        "echo '${cmd}' && ${cmd}";
      wantedBy = [ "multi-user.target" ];
    };
  };
}
