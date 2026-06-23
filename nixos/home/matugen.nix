{
  config,
  inputs,
  user,
  ...
}:
{
  imports = [
    inputs.matugen.nixosModules.default
  ];

  # home.configFile."${user.config}".source =
  #   "${config.programs.matugen.theme.files}/${user.config}/colors.conf";

  programs.matugen = {
    enable = true;
    variant = "dark";
    jsonFormat = "hex";

    # Define the templates that should receive these colors
    # templates = {
    #   kitty = {
    #     input_path = "./../matugen/kitty.conf";
    #     output_path = "${user.config}/kitty/colors.conf";
    #   };
    # };
  };
}
