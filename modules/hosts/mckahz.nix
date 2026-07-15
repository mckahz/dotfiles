{ den, ... }:
{
  den.aspects.mckahz = {
    includes = [
      den.batteries.define-user
      den.batteries.primary-user

      den.aspects.terminal
      den.aspects.desktop-shell
      den.aspects.browser
      den.aspects.editor
      den.aspects.music
      den.aspects.discord
    ];
  };
}
