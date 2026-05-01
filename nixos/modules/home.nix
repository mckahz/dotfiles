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
    inputs.noctalia.homeModules.default
  ];

  programs.noctalia-shell = {
    enable = true;
    settings = {
      # configure noctalia here
      spawn-at-startup = [
        {
          command = [
            "noctalia-shell"
          ];
        }
      ];
      bar = {
        density = "compact";
        position = "right";
        showCapsule = false;
        widgets = {
          left = [
            {
              id = "ControlCenter";
              useDistroLogo = true;
            }
            {
              id = "Network";
            }
            {
              id = "Bluetooth";
            }
          ];
          center = [
            {
              hideUnoccupied = false;
              id = "Workspace";
              labelMode = "none";
            }
          ];
          right = [
            {
              alwaysShowPercentage = false;
              id = "Battery";
              warningThreshold = 30;
            }
            {
              formatHorizontal = "HH:mm";
              formatVertical = "HH mm";
              id = "Clock";
              useMonospacedFont = true;
              usePrimaryColor = true;
            }
          ];
        };
      };
      colorSchemes.predefinedScheme = "Monochrome";
      general = {
        avatarImage = "/home/drfoobar/.face";
        radiusRatio = 0.2;
      };
      location = {
        monthBeforeDay = true;
        name = "Marseille, France";
      };
    };
    # this may also be a string or a path to a JSON file.
  };

  programs.home-manager.enable = true;
  programs.bash.enable = true;
}
