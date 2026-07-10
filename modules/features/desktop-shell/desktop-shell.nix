{ inputs, den, ... }:
{
  den.aspects.desktop-shell = {
    includes = [
      den.aspects.terminal
      den.aspects.hyprland
      den.aspects.greeter
    ];
  };
}
