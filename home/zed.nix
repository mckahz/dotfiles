{ pkgs, ... }: {
  home.packages = [ pkgs.zed-editor ];
  programs.zed-editor = {
    enable = false;

    userSettings = {
      buffer_font_size = 16;
      features = {
        copilot = false;
      };
      telemetry = {
        metrics = false;
      };
      ui_font_size = 16;
      vim_mode = true;

    };

    userKeymaps = [
      {
        context = "Editor && vim_mode==normal";
        bindings = {
          shift-u = "editor::Redo";
        };
      }
    ];
  };
}
