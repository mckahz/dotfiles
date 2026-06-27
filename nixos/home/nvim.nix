{ ... }: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    waylandSupport = true;
    extraConfig = ''
      set number relativenumber
    '';
  };
}
