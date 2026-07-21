{
  den.aspects.network.nixos = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [ localsend ];

    programs.localsend.enable = true;
    programs.localsend.openFirewall = true;

    networking.firewall.enable = true;
  };
}
