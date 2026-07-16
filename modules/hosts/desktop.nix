{ inputs, den, ... }:
{
  den.aspects.desktop = {
    includes = [
      den.aspects.keyboard
      den.aspects.nvidia
    ];

    nixos =
      {
        config,
        lib,
        pkgs,
        modulesPath,
        ...
      }:
      {
        keyboard.device = "/dev/input/by-id/usb-Razer_Razer_Cynosa_Chroma-event-kbd";

        nixpkgs.config.permittedInsecurePackages = [
          "broadcom-sta-6.30.223.271-59-6.18.38"
        ];

        environment.systemPackages = with pkgs; [ wl-mirror ];

        # rename linktosharedfolder???
        system.activationScripts.linkToStorage.text =
          let
            createSymlink = path: ''
              if [[ ! -h "~/${path}" ]]; then
                ln -s "~/STORAGE/${path}" "~/${path}"
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

        # HARDWARE
        imports = [
          (modulesPath + "/installer/scan/not-detected.nix")
        ];

        boot.initrd.availableKernelModules = [
          "xhci_pci"
          "ahci"
          "usbhid"
          "sd_mod"
        ];
        boot.initrd.kernelModules = [ ];
        boot.kernelModules = [
          "kvm-intel"
          "wl"
          "uinput"
        ];
        boot.extraModulePackages = [ config.boot.kernelPackages.broadcom_sta ];

        fileSystems."/" = {
          device = "/dev/disk/by-uuid/dd19768c-f638-4558-8f82-eb2fc0adb424";
          fsType = "ext4";
        };

        fileSystems."/boot" = {
          device = "/dev/disk/by-uuid/92B7-59A2";
          fsType = "vfat";
          options = [
            "fmask=0077"
            "dmask=0077"
          ];
        };

        fileSystems."/home/mckahz/STORAGE" = {
          device = "/dev/disk/by-uuid/4C3A432F3A4314FC";
          fsType = "ntfs3";
          options = [
            "uid=1000"
          ];
        };

        fileSystems."/home/mckahz/GAMES" = {
          device = "/dev/disk/by-uuid/6CEADB28EADAED78";
          fsType = "ntfs3";
          options = [
            "uid=1000"
          ];
        };

        swapDevices = [
          { device = "/dev/disk/by-uuid/88e6d414-81f6-4f65-9758-e34dcb215751"; }
        ];

        nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
        hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
      };
  };
}
