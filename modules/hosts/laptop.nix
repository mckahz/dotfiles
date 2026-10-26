{ inputs, den, ... }:
{
  den.hosts.x86_64-linux.laptop.users.mckahz.classes = [
    "hjem"
    "nixos"
  ];

  den.aspects.laptop = {
    includes = [
      den.aspects.school
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
        networking.hostName = "laptop";
        flake = "/home/mckahz/.dotfiles";

        keyboard.enable = true;
        login.automatic = false;
        login.defaultUser = "mckahz";

        boot.zswap = {
          enable = true;
          maxPoolPercent = 50;
          shrinkerEnabled = true;
          compressor = "zstd";
          acceptThresholdPercent = 90;
        };

        boot.kernelParams = [
          "zswap.enabled=1"
          "zswap.max_pool_percent=50"
          "zswap.shrinker_enabled=1"
          "zswap.compressor=zstd"
          "zswap.accept_threshold_percent=90"
        ];

        system.stateVersion = "25.11";

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

        swapDevices = [
          {
            device = "/dev/disk/by-uuid/1e9765fa-1322-4eb9-87e0-f525c8de1aaf";
            options = [ "discard" ];
          }
        ];
        boot.resumeDevice = "/dev/nvme0n1p3";

        nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
        hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
      };
  };
}
