{ inputs, den, ... }:
{
  den.hosts.x86_64-linux.minipc.users.gmang.classes = [
    "hjem"
    "nixos"
  ];

  den.aspects.minipc = {
    includes = [ ];

    nixos =
      {
        config,
        lib,
        pkgs,
        modulesPath,
        ...
      }:

      {
        networking.hostName = "minipc";
        flake = "/home/gmang/.dotfiles";
        vim = false;

        login.automatic = true;
        login.defaultUser = "gmang";

        environment.systemPackages = with pkgs; [ openrgb-with-all-plugins ];

        services.hardware.openrgb.enable = true;

        # DO NOT TOUCH PAST HERE!!!

        system.stateVersion = "25.11";

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

    provides.to-users.hjem = {
      xdg.config.files."mango/monitors.conf".text = ''
        monitor_rule=name:HDMI-A-1,width:1360,height:768,refresh:60,x:0,y:0
        monitor_rule=name:DP-2,width:1920,height:1080,refresh:59.94000,x:1360,y:0,primary:1
        monitor_rule=name:DP-3,width:1920,height:1080,refresh:60,x:3280,y:0
      '';
    };
  };
}
