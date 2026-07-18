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
      # TODO: replace everything until the comment at the end of the file
      # with the contents of /etc/nixos/hardware-configuration.nix
      # then add the following just above `imports = [...]` just like below.
      #
      # autologin.enable = true;
      # autologin.user = "gmang";
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
      }
    # here
    ;
  };
}
