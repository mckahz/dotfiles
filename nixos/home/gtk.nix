{pkgs, ...}: {
gtk = {
  enable = true;
  cursorTheme = {
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
  };
  gtk3.extraConfig = {
    "gtk-cursor-theme-name" = "Bibata-Modern-Classic";
  };
};
}
