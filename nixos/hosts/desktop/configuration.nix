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

  services.udisks2.settings = {
    # fix NTFS mount, from https://wiki.archlinux.org/title/NTFS#udisks_support
    "mount_options.conf" = {
      defaults = {
        ntfs_defaults = "uid=$UID,gid=$GID,noatime,prealloc";
      };
    };
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
