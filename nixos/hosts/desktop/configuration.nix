{
  user,
  lib,
  config,
  pkgs,
  ...
}:
{
  networking.hostName = "desktop";

  programs.regreet.enable = true;
  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = "${pkgs.niri}/bin/niri-session";
        user = user.name;
      };
      default_session = initial_session;
    };
  };

  imports = [
    ./hardware-configuration.nix
  ];

  nvidia.enable = true;

  keyboard = {
    enable = true;
    path = ./keyboard.kbd;
  };

  boot.extraModulePackages = [ config.boot.kernelPackages.broadcom_sta ];
  boot.kernelModules = [ "wl" ];

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

  # rename linktosharedfolder???
  system.activationScripts.linkToStorage.text =
    let
      createSymlink = path: ''
        if [[ ! -h "${user.home}/${path}" ]]; then
          ln -s "${user.home}/STORAGE/${path}" "${user.home}/${path}"
        fi
      '';
    in

    lib.join "\n" (
      map createSymlink [
        "Pictures"
        "Desktop"
        "Downloads"
        "Documents"
        "Music"
        "Public"
        "Templates"
        "Videos"
      ]
    );

  system.stateVersion = "25.11";
}
