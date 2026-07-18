{ den, ... }:
{
  den.aspects.gmang = {
    includes = [
      den.batteries.define-user
      den.batteries.primary-user

      den.aspects.terminal
      den.aspects.desktop-shell
      den.aspects.theme
      den.aspects.browser
      den.aspects.editor
      den.aspects.spotify
      den.aspects.discord
    ];

    nixos = _: {
      autologin.enable = true;
      autologin.user = "gmang";
    };
  };
}
