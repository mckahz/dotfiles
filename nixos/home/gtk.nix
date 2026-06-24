{ pkgs, ... }:
{
  gtk = {
    enable = true;

    iconTheme = {
      name = "Tela-circle";
      package = pkgs.tela-circle-icon-theme;
    };
  };
}
