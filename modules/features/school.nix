{ ... }: {
  den.aspects.school = {
    nixos = { pkgs, lib, ... }: {
      options.school.enable = lib.mkOption {
        default = false;
        type = lib.types.bool;
      };

      config = {
        environment.systemPackages = with pkgs; [
          ciscoPacketTracer9
          zoom-us
        ];

        nixpkgs.config.allowUnfree = lib.mkForce true;

        services.xserver.videoDrivers = [ "vmware" ];
        #virtualisation.vmware.guest.enable = true;
        virtualisation.vmware.host.enable = true;
      };
    };
  };
}
