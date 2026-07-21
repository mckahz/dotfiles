{
  den.aspects.network.nixos.networking.firewall = {
    enable = true;

    allowedTCPPorts = [ 53317 ]; # replace
    allowedUDPPorts = [ 53317 ]; # replace
  };
}
