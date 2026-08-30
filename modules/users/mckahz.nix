{ den, ... }:
{
  den.aspects.mckahz = {
    includes = [
      den.batteries.define-user
      den.batteries.primary-user

      den.aspects.torrent
      den.aspects.keyboard
      den.aspects.terminal
      den.aspects.desktop-shell
      den.aspects.theme
      den.aspects.browser
      den.aspects.editor
      den.aspects.spotify
      den.aspects.discord
      den.aspects.gaming
      den.aspects.network
    ];

    provides.to-hosts.nixos = { ... }: {
      keyboard.enable = true;
      keyboard.device = "/dev/input/by-path/platform-i8042-serio-0-event-kbd";
    };
  };
}
