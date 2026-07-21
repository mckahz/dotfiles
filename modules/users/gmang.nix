{ den, ... }:
{
  den.aspects.gmang = {
    includes = [
      den.batteries.define-user
      den.batteries.primary-user

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
  };
}
