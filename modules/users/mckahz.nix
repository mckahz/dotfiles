{ den, ... }:
{
  den.aspects.mckahz = {
    includes = [
      den.batteries.define-user
      den.batteries.primary-user

      den.aspects.school
      den.aspects.torrent
      den.aspects.keyboard
      den.aspects.terminal
      den.aspects.desktop-shell
      den.aspects.theme
      den.aspects.browser
      den.aspects.editor
      den.aspects.spotify
      den.aspects.discord
    ];
  };
}
