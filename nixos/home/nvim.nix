{ ... }: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    waylandSupport = true;
    initLua = builtins.readFile ./.config/nvim/init.lua;
  };
}
