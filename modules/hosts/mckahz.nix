{ den, ... }:
{
  den.aspects.mckahz = {
    includes = [
      den.batteries.define-user
      den.batteries.primary-user

      den.aspects.browser
      den.aspects.editor
      den.aspects.desktop-shell
    ];
  };
}
