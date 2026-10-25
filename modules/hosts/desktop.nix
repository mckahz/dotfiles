{ inputs, den, ... }:
{
  den.hosts.x86_64-linux.desktop.users.mckahz.classes = [
    "hjem"
    "nixos"
  ];

  den.aspects.desktop = {
    includes = [
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
        networking.hostName = "desktop";
        flake = "/home/mckahz/.dotfiles";

        keyboard.enable = true;
        login.automatic = true;
        login.defaultUser = "mckahz";

        nixpkgs.config.permittedInsecurePackages = [
          "broadcom-sta-6.30.223.271-63-7.2.12"
        ];

        environment.systemPackages = with pkgs; [ wl-mirror ];

        # HARDWARE
     	  imports =
     	    [ (modulesPath + "/installer/scan/not-detected.nix")
     	    ];

     	  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
     	  boot.initrd.kernelModules = [ ];
     	  boot.kernelModules = [ "kvm-intel" ];
     	  #boot.extraModulePackages = [ ];
        boot.extraModulePackages = with config.boot.kernelPackages; [ rtw89 ];

     	  fileSystems."/" =
     	    { device = "/dev/disk/by-uuid/da1c89ab-917e-4418-b4ce-ab6496983fd6";
     	      fsType = "ext4";
     	    };

     	  fileSystems."/boot" =
     	    { device = "/dev/disk/by-uuid/D2C8-D811";
     	      fsType = "vfat";
     	      options = [ "fmask=0077" "dmask=0077" ];
     	    };

          fileSystems."/home/mckahz/STORAGE" =
              { device = "/dev/disk/by-uuid/49345380-2f15-427f-92c7-a5163611a8d1";
                fsType = "ext4";
                options = [
                  "nofail"
                ];
              };

          fileSystems."/home/mckahz/GAMES" =
            { device = "/dev/disk/by-uuid/29054fdb-aae1-44a3-988e-a525ffcca5c2";
              fsType = "ext4";
              options = [
                "nofail"
                "exec"
              ];
            };

          swapDevices =
     	    [ { device = "/dev/disk/by-uuid/5c75cc8a-2cb7-4369-8b67-7215f12fa2c5"; }
     	    ];

     	  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
     	  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
      };
    };
}
