{
  pkgs,
  inputs,
  user,
  ...
}:

{
  home.username = user.name;
  home.homeDirectory = user.home;
  home.stateVersion = "25.11"; # Please read the comment before changing.
  home.packages = [
    pkgs.whitesur-gtk-theme
  ];
  home.file = { };
  home.sessionVariables = { };

  imports = [
    inputs.dms.homeModules.dank-material-shell
    inputs.dms.homeModules.niri
  ];

  programs.home-manager.enable = true;
  programs.bash.enable = true;
  programs.dank-material-shell = {
    enable = true;
    enableSystemMonitoring = true;
    dgop.package = inputs.dgop.packages.${pkgs.system}.default;
    niri = {
      enableKeybinds = true; # Sets static preset keybinds
      enableSpawn = true; # Auto-start DMS with niri, if enabled
    };
  };
}
