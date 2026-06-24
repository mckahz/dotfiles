{ ... }: {
  programs.zsh = {
    enable = false;

    oh-my-zsh = {
      enable = false;
      plugins = [
        "git"
        "z"
      ];
      #theme = "headline";
    };

    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    setOptions = [
      "HIST_IGNORE_ALL_DUPS"
    ];
  };
}
