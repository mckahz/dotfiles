{ ... }: {
  autoCmd = 

  [
  {
    event = ["BufWritePre"];
    pattern = "*";
    callback = { __raw = ''
    function(args)
      vim.lsp.buf.format({ bufnr = args.buf, async = false })
    end
    ''; };
      }
];

}
