{ lib, ... }: {
  plugins.startup = {
    enable = true;
    settings = {
      colors = {
        background = "#ffffff";
        folded_section = "#ffffff";
      };

      header = {
        type = "text";
        oldfiles_directory = false;
        align = "center";
        fold_section = false;
        title = "Header";
        margin = 5;
        content =
          let
            base = ''
                           /\\\                              /\\\                         
              /\\/\\\\\\   \///   /\\\    /\\\  /\\\    /\\\ \///     /\\\\\  /\\\\\      
              \/\\\////\\\   /\\\ \///\\\/\\\/  \//\\\  /\\\   /\\\  /\\\///\\\\\///\\\   
               \/\\\  \//\\\ \/\\\   \///\\\/     \//\\\/\\\   \/\\\ \/\\\ \//\\\  \/\\\  
                \/\\\   \/\\\ \/\\\    /\\\/\\\     \//\\\\\    \/\\\ \/\\\  \/\\\  \/\\\ 
                 \/\\\   \/\\\ \/\\\  /\\\/\///\\\    \//\\\     \/\\\ \/\\\  \/\\\  \/\\\
                  \///    \///  \///  \///    \///      \///      \///  \///   \///   \///
            '';
            getLines = lib.strings.splitString "\n";
            getChars = lib.strings.stringToCharacters;
            replaceBackslashes = x: x; # map (char: if char == "\\" then "\e[0;31m\\[0m" else char);
            join = lib.strings.join;
          in
          map (join "") (map replaceBackslashes (map getChars (getLines base)));
        highlight = "Statement";
        default_color = "";
        oldfiles_amount = 0;
      };

      body = {
        type = "mapping";
        oldfiles_directory = false;
        align = "center";
        fold_section = false;
        title = "Menu";
        margin = 5;
        content = [
          [
            " Recent Files"
            "Telescope oldfiles"
            "fr"
          ]
          [
            " Find File"
            "Telescope find_files"
            "ff"
          ]
          [
            "󰍉 Find Word"
            "Telescope live_grep"
            "fw"
          ]
          # [
          #   "󰍉 Reload Session"
          #   "echo 'not yet implemented'"
          #   "rs"
          # ]
        ];
        highlight = "string";
        default_color = "";
        oldfiles_amount = 0;
      };

      options = {
        paddings = [
          1
          3
        ];
      };

      parts = [
        "header"
        "body"
      ];
    };
  };
}
