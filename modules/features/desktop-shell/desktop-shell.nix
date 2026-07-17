{ inputs, den, ... }:
{
  den.aspects.desktop-shell = {
    includes = [
      den.aspects.terminal

      den.aspects.hyprland
      den.aspects.keybinds
      den.aspects.cursor

      den.aspects.noctalia
      den.aspects.greeter
    ];
  };
}
