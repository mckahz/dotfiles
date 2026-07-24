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
    provides.to-users.homeManager = { config, ... }: {
      vim = false;
      theme.wallpapers = "${config.home.homeDirectory}/Pictures/wallpapers";

      hyprland = {
        lock.enable = true;
        masterOrientation = "top";
        # ordered left to right
        monitors = [
          {
            output = "HDMI-A-1";
            mode = "1360x768@60";
            position = "-1360x0";
            transform = 0;
            scale = 1;
          }
          {
            output = "DP-2";
            mode = "1920x1080@59.94000";
            position = "0x0";
            transform = 0;
            scale = 1;
          }
          {
            output = "DP-3";
            mode = "1920x1080@60.00000";
            position = "1920x0";
            transform = 3;
            scale = 1;
          }

        ];
      };
    };

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
