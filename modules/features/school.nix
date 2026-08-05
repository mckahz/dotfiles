{ ... }: {
  den.aspects.school = {
    homeManager = { host, ... }: {
      dconf.settings = {
        "org/virt-manager/virt-manager/connections" = {
          autoconnect = [ "qemu:///system" ];
          uris = [ "qemu:///system" ];
        };
      };
      users.users.${host.name}.extraGroups = [ "libvirtd" ];
    };

    nixos = { pkgs, lib, ... }: {
      programs.virt-manager.enable = true;

      environment.systemPackages = with pkgs; [
        ciscoPacketTracer9
        zoom-us
        virtiofsd
        spice
        hunspell
      ];

      users.groups.libvirtd.members = [
        "mckahz"
        "gmang"
      ];

      virtualisation.libvirtd.enable = true;

      virtualisation.spiceUSBRedirection.enable = true;

      nixpkgs.config.allowUnfree = lib.mkForce true;

      # services.xserver.videoDrivers = [ "vmware" ];
      # virtualisation.vmware.guest.enable = true;
      # virtualisation.vmware.host.enable = true;
    };
  };
}
