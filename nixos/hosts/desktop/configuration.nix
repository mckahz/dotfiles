{ user, lib, ... }:
{
  networking.hostName = "desktop";

  imports = [
    ./hardware-configuration.nix
  ];

  nvidia.enable = true;

  keyboard = {
    enable = true;
    path = ./keyboard.kbd;
  };

  fileSystems =
    let
      ntfs-drives = [
        "${user.home}/GAMES"
        "${user.home}/STORAGE"
      ];
    in
    lib.genAttrs ntfs-drives (path: {
      options = [ "uid=1000" ];
    });

  system.stateVersion = "25.11";
}
