{ lib, pkgs, ... }:
{
  plugins.conform-nvim = {
    enable = true;

    settings = {
      formatters_by_ft = {
        nix = [ "nixfmt" ];
        lua = [ "stylua" ];
      };
      format_on_save = {
        timeout_ms = 500;
        lsp_format = "fallback";
      };
    };
  };

  plugins.lspconfig.enable = true;

  extraPackages = with pkgs; [
    nixfmt
    stylua
  ];

  lsp = {
    servers = {
      lua_ls.enable = true;
      nixd.enable = true;
    };
  };
}
