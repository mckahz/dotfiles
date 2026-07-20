{ inputs, den, ... }:
{
  den.hosts.x86_64-linux.minipc.users.gmang.classes = [
    "homeManager"
    "nixos"
  ];

  den.aspects.minipc = {
    includes = [ ];

    # TODO: Uncomment when you've copied over hardware-configuration.nix,
    # logged on, and run `sudo passwd gmang` to reset your password.
    # Only activate if you want a lock screen
    # provides.to-users.homeManager.lock.enable = true;

    nixos =
      {
        config,
        lib,
        pkgs,
        modulesPath,
        ...
      }:

      {
        autologin.enable = true;
        autologin.user = "gmang";
        vim = false;

        # theme = {
        #   base16Scheme = "${pkgs.base16-schemes}/share/themes/ayu-mirage.yaml";
        #   wallpaper = ./wallpaper.jpg;
        # };

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
        boot.kernelModules = [ "kvm-amd" ];
        boot.extraModulePackages = [ ];

        fileSystems."/" = {
          device = "/dev/disk/by-uuid/2fe23d4b-a0b5-4758-a8ab-f7ef31806bfb";
          fsType = "ext4";
        };

        fileSystems."/boot" = {
          device = "/dev/disk/by-uuid/8399-66A6";
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
