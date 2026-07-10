{ lib, ... }: {
  services.gnome-keyring.enable = lib.mkForce false;
}
