{ den, ... }:
{
  den.aspects.mckahz = {
    includes = [
      den.batteries.define-user
      den.batteries.primary-user

      den.aspects.terminal
      den.aspects.desktop-shell
      den.aspects.theme
      den.aspects.browser
      den.aspects.editor
      den.aspects.music
      den.aspects.discord
    ];

    homeManager = {
      xdg.configHome = "/home/mckahz/.config";
    };
  };
}
