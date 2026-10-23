{ inputs, den, ... }:
{
  den.aspects.desktop-shell = {
    includes = [
      den.aspects.terminal
      den.aspects.mango
      den.aspects.noctalia
    ];
  };
}
