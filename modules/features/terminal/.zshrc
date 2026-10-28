setopt autocd

HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
unsetopt HIST_VERIFY               # Do not execute immediately upon history expansion.
unsetopt HIST_NO_STORE             # Disabled so the history command can view history entries normally

setopt auto_cd auto_pushd pushd_minus correct extended_glob interactive_comments rm_star_wait
unsetopt beep pushd_ignore_dups flow_control
export KEYTIMEOUT=5
unalias run-help 2>/dev/null
autoload -Uz run-help add-zsh-hook compinit edit-command-line zmv up-line-or-beginning-search down-line-or-beginning-search
zmodload zsh/stat zsh/datetime zsh/zle
zle -N edit-command-line

# PLUGINS

eval "$(starship init zsh)"
eval "$(direnv hook zsh)"

source <(fzf --zsh)
source ./.antidote.zsh

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

zstyle ':completion:*' menu no
zstyle ':fzf-tab:*' fzf-flags --color=fg:1,fg+:2 --bind=tab:accept
zstyle ':fzf-tab:*' switch-group '<' '>'
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls -vF --color --group-directories-first $realpath'
zstyle ':fzf-tab:complete:ls:*' fzf-preview 'ls -vF --color --group-directories-first $realpath'
zstyle ':fzf-tab:complete:(-command-|-parameter-|-brace-parameter-|export|unset|expand):*' fzf-preview 'echo ${(P)word}'
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-preview '[[ $group == "[process ID]" ]] && ps --pid=$word -o cmd --no-headers -w -w'
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-flags --preview-window=down:3:wrap
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':fzf-tab:complete:git-(add|diff|restore):*' fzf-preview \
'git diff $word | delta'
zstyle ':fzf-tab:complete:git-log:*' fzf-preview \
'git log --color=always $word'
zstyle ':fzf-tab:complete:git-help:*' fzf-preview \
'git help $word | bat -plman --color=always'
zstyle ':fzf-tab:complete:git-show:*' fzf-preview \
'case "$group" in
"commit tag") git show --color=always $word ;;
*) git show --color=always $word | delta ;;
esac'
zstyle ':fzf-tab:complete:git-checkout:*' fzf-preview \
'case "$group" in
"modified file") git diff $word | delta ;;
"recent commit object name") git show --color=always $word | delta ;;
*) git log --color=always $word ;;
esac'
