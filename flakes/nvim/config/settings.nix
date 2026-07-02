{ pkgs, ... }: {
  opts = {
    clipboard = "unnamedplus";
  };
  globalOpts = {
    # Line wrap
    wrap = true;
    linebreak = true;
    breakindent = true;

    # Line numbers
    number = true;
    relativenumber = true;
    fillchars = {
      eob = " ";
    };

    # Enable more colors (24-bit)
    termguicolors = true;

    # Have a better completion experience
    completeopt = [
      "menuone"
      "noselect"
      "noinsert"
    ];

    # Always show the signcolumn, otherwise text would be shifted when displaying error icons
    signcolumn = "yes";

    # Enable mouse
    mouse = "a";

    # Search
    ignorecase = true;
    smartcase = true;

    # Configure how new splits should be opened
    splitright = true;
    splitbelow = true;

    list = true;
    # NOTE: .__raw here means that this field is raw lua code
    listchars.__raw = "{ tab = '» ', trail = '·', nbsp = '␣' }";

    expandtab = true;
    tabstop = 4;
    shiftwidth = 2;
    softtabstop = 0;
    smarttab = true;

    # System clipboard support, needs xclip/wl-clipboard
    clipboard = {
      providers.wl-copy = {
        enable = true;
        package = pkgs.wl-clipboard;
      };
      register = "unnamedplus";
    };

    # Set encoding
    encoding = "utf-8";
    fileencoding = "utf-8";

    # Save undo history
    undofile = true;
    swapfile = true;
    backup = false;
    autoread = true;

    # Highlight the current line for cursor
    cursorline = true;

    # Show line and column when searching
    ruler = true;

    # Global substitution by default
    gdefault = true;

    # Start scrolling when the cursor is X lines away from the top/bottom
    scrolloff = 5;
  };

  userCommands = {
    Q.command = "q";
    Q.bang = true;
    Wq.command = "q";
    Wq.bang = true;
    WQ.command = "q";
    WQ.bang = true;
    W.command = "q";
    W.bang = true;
  };

  globals.mapleader = " ";
}
