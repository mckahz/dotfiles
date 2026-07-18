{ inputs, den, ... }:
{
  den.hosts.x86_64-linux.laptop.users.mckahz.classes = [
    "homeManager"
    "nixos"
  ];

  den.aspects.laptop = {
    includes = [ ];

    provides.to-users.homeManager.lock.enable = true;

    nixos =
      {
        config,
        lib,
        pkgs,
        modulesPath,
        ...
      }:

      {
        keyboard.enable = true;
        keyboard.device = "/dev/input/by-path/platform-i8042-serio-0-event-kbd";

        autologin.enable = true;
        autologin.user = "mckahz";

        imports = [
          (modulesPath + "/installer/scan/not-detected.nix")
        ];

        boot.initrd.availableKernelModules = [
          "nvme"
          "xhci_pci"
        ];
        boot.initrd.kernelModules = [ ];
        boot.kernelModules = [
          "kvm-amd"
          "uinput"
        ];
        boot.extraModulePackages = [ ];

        fileSystems."/" = {
          device = "/dev/disk/by-uuid/05b9f2cd-f792-4514-88fa-619c495dcc66";
          fsType = "ext4";
        };

        fileSystems."/boot" = {
          device = "/dev/disk/by-uuid/8A92-629F";
          fsType = "vfat";
          options = [
            "fmask=0077"
            "dmask=0077"
          ];
        };

        swapDevices = [ ];

        nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
        hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
      };
  };
}
