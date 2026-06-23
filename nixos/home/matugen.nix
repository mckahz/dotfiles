{ inputs, ... }: {
  imports = [
    inputs.matugen.homeManagerModules.default
  ];

  programs.matugen = {
    enable = true;
    variant = "dark";
    jsonFormat = "hex";

    # Define the templates that should receive these colors
    # templates = {
    #   kitty = {
    #     input_path = "./templates/kitty.conf";
    #     output_path = "${config.xdg.configHome}/kitty/colors.conf";
    #   };
    #   # Add other apps like Hyprland, Waybar, etc.
    # };
  };
}
