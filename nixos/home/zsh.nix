{ ... }: {
  programs.zsh = {
    enable = true;

    oh-my-zsh = {
      enable = true;
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
