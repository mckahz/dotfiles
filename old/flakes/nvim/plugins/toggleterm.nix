{ ... }: {
  keymaps = [
    {
      action = "<cmd>ToggleTerm<CR>";
      key = "<leader>t";
    }
  ];
  plugins.toggleterm.enable = true;
}
