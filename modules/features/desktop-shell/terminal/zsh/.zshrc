# =====================
# ||  ==> ZSHRC <==  ||
# =====================

# =====================================================================
# INITIALIZATION
# =====================================================================

# === Profiling Zsh Startup ===
[[ "$ZPROF" == 1 ]] && zmodload zsh/zprof

# === Interactivity check ===
[[ $- != *i* ]] && return

# === Powerlevel10k Instant Prompt === (Keep low)
# [[ -r "$XDG_CACHE_HOME/p10k-instant-prompt-${(%):-%n}.zsh" ]] && source "$XDG_CACHE_HOME/p10k-instant-prompt-${(%):-%n}.zsh"

# =====================================================================
# GENERAL
# =====================================================================

setopt auto_cd auto_pushd pushd_minus correct extended_glob interactive_comments rm_star_wait
unsetopt beep pushd_ignore_dups flow_control
export KEYTIMEOUT=5
unalias run-help 2>/dev/null
autoload -Uz run-help add-zsh-hook compinit edit-command-line zmv up-line-or-beginning-search down-line-or-beginning-search
zmodload zsh/stat zsh/datetime zsh/zle
zle -N edit-command-line
SPROMPT="Posting cringe I see. Wanna change '%U%F{red}%R%u%f' to '%U%F{blue}%r%f%u'? %F{yellow}ฅ^•ﻌ•^ฅ ~[%fnyae%F{yellow}]%f: "
[[ -d $ZCACHEDIR ]] || mkdir -p "$ZCACHEDIR"

# === LS Colors === (we straight CODE GOLFIN' it)
() { [[ -f $1 && ! $1 -ot $2 ]] && dircolors -b $1 > $2; source $2 2>&-;
} "${ZDOTDIR}/dircolors" "${ZCACHEDIR}/dircolors.zsh"

# =====================================================================
# TAB COMPLETION (COMPINIT)
# =====================================================================

# === Community Completions ===
[[ -d "$ZPLUGINDIR/zsh-completions/src" ]] && fpath=("${ZPLUGINDIR}/zsh-completions/src" $fpath)

# === Compdump Configuration ===
export ZCOMPCACHE="${ZCACHEDIR}/zcompcache-${HOST}-${ZSH_VERSION}"
export ZCOMPDUMP="${ZCACHEDIR}/zcompdump-${HOST}-${ZSH_VERSION}"

#compinit bb
[[ -s "$ZCOMPDUMP"(#qN.m-1) ]] && compinit -C -d "$ZCOMPDUMP" || compinit -d "$ZCOMPDUMP"
_comp_options+=(globdots)

# === Set Options ===
setopt always_to_end
zstyle ':completion:*' menu select
zstyle ':completion:*' group-name ''
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*:descriptions' format '%B%F{yellow}-- %d --%b%f'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=01;31=01;33'
zstyle ':completion:*:*:kill:*:processes' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
zstyle ':completion:*:*:kill:*' insert-ids single
zstyle ':completion:*:cd:*' ignore-parents parent pwd
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path $ZCOMPCACHE

# =====================================================================
# HISTORY CONFIGURATION
# =====================================================================

export HISTFILE="${XDG_STATE_HOME}/zsh/history"
[[ -d "${HISTFILE:h}" ]] || mkdir -p "${HISTFILE:h}"

HISTSIZE=10000
SAVEHIST=10000

# === Set Options ===
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
unsetopt HIST_VERIFY               # Do not execute immediately upon history expansion.
unsetopt HIST_NO_STORE             # Disabled so the history command can view history entries normally

# =====================================================================
# ALIASES
# =====================================================================

# === Useful ===
alias shrc='${EDITOR} "${ZDOTDIR}/.zshrc"'
alias loadsh='source "${ZDOTDIR}/.zshrc"'
alias _zprof='export ZPROF=1; time zsh -i -c exit; unset ZPROF'
alias hyprlua='${EDITOR} "${XDG_CONFIG_HOME}/hypr/hyprland.lua"'
alias bye='read -r '\''REPLY?Really power off? [Y/n] '\'' || exit; [[ -z $REPLY || $REPLY = [Yy]* ]] && sudo poweroff || echo "Shutdown cancelled."'
alias pkmn="hyprctl dispatch \"hl.dsp.exec_cmd('antimicrox', { workspace = 'special:scratch-pad silent' })\" && cd ${HOME}/Games/2DFM/PKMNCC-Launcher/ && (wine pkmncc.exe & disown) && cd -"
# --global--
alias -g CP='| wl-copy' #Copy cmd output to clipboard
alias -g NE='2>/dev/null' #Pipe error into null
alias -g ZTEST="&& echo 'yay!' || echo 'shit!'"
alias -g B='| bat -pp -l conf'

# === Set Default Flags/Options ===
alias ls='ls -vF --color=auto --group-directories-first --hyperlink=auto'
alias lsa='ls -A'
alias grep='grep -C1 -i --color=auto --group-separator="*===========================/ ₍˄·͈༝·͈˄₎◞ /===========================*"'
alias bat='bat -P --theme="ansi"'
alias info="info --vi-keys -v link-style=blue,underline -v active-link-style=cyan,underline,bold -v match-style=bgyellow,black"
alias zmv='zmv -i -W'

# === Directory Navigation ===
alias home='cd "$HOME" && ls'
alias root='cd / && ls'
alias dtop='cd "${XDG_DESKTOP_DIR}" 2>/dev/null && ls'
alias hyprd='cd "${XDG_CONFIG_HOME}/hypr/" && ls'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# === Alt Names & Typo Helpers ===
alias nv='nvim'
alias help='run-help'
alias dsmd='dmsd'
alias cleart='clear'
alias cleat='clear'
alias claer='clear'

# === Dumbshit ===
alias tmatrix='tmatrix -c default -C default -t SUCKING-DICK-AND-COCK'
alias cmatrix='tmatrix'

# =====================================================================
# KEYBINDS
# =====================================================================

# === Which Way Western Man? ===
bindkey -v    # vi mode
#bindkey -e   # Emmacs Mode

# === Make Bindable ===
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# === General Bindings ===
bindkey '^R' history-incremental-search-backward
bindkey -M vicmd 'U' redo
bindkey -M viins ' ' magic-space
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search
bindkey -M vicmd 'k' up-line-or-beginning-search
bindkey -M vicmd 'j' down-line-or-beginning-search

# =====================================================================
# CUSTOM FUNCTIONS
# =====================================================================

# === CD With Yazi (bound to CTRL+O) ===
yazicd() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	command rm -f -- "$tmp"
}
bindkey -s '^o' '^uyazicd\n'

# === Ez Extractions ===
extract() {
  if [[ "$1" == (--help|-h|help) || -z "$1" ]]; then
		echo "${C_CYAN}📦 extract${C_NC}: Universal archive extractor (supports multiple files)."
		echo "Usage: ${C_YELLOW}extract <archive> [archive...]${C_NC}"
		return 0
	fi

	for file in "$@"; do
		if [ -f "$file" ] ; then
			echo "${C_CYAN}Extracting '$file'...${C_NC}"
			case "$file" in
				*.tar.bz2)   tar xjf "$file"     ;;
				*.tar.gz)    tar xzf "$file"     ;;
				*.bz2)       bunzip2 "$file"     ;;
				*.rar)       unrar x "$file"     ;;
				*.gz)        gunzip "$file"      ;;
				*.tar)       tar xf "$file"      ;;
				*.tbz2)      tar xjf "$file"     ;;
				*.tgz)       tar xzf "$file"     ;;
				*.zip)       unzip "$file"       ;;
				*.Z)         uncompress "$file"  ;;
				*.7z)        7z x "$file"        ;;
				*)           echo "${C_RED}❌ '$file' cannot be extracted via extract().${C_NC}" ;;
			esac
		else
			echo "${C_RED}❌ '$file' is not a valid file.${C_NC}"
		fi
	done
	echo "${C_GREEN}✅ Extraction complete!${C_NC}"
}

# === EZ Git Shortcuts ===
#the commands
ez_gitcommit() {
  BUFFER="git add .
git commit -m \"\""
  CURSOR=25
}
ez_gitpush() {
  BUFFER="git add .
git commit -m \"\"
git push"
  CURSOR=25
}
#make em widgets
zle -N ez_gitcommit
zle -N ez_gitpush
#bind em
bindkey -r '^G'
bindkey '^Gc' ez_gitcommit
bindkey '^Gp' ez_gitpush

# =====================================================================
# PLUGINS
# =====================================================================

# === Plugin Sourcing Helper ===
zplug() {
  local plugin="$ZPLUGINDIR/$1"
  [[ -r "$plugin" ]] && source "$plugin"
}

# Source starship
eval "$(starship init zsh)"

# === BETTER VI MODE ===
zplug zsh-vi-mode/zsh-vi-mode.plugin.zsh

# === FZF + FZF-TAB ===
if (( ${+commands[fzf]} )); then
  #fzf
  source <(fzf --zsh)
  zplug fzf/shell/completion.zsh
  zplug fzf/shell/key-bindings.zsh

  #fzf-tab
  zplug fzf-tab/fzf-tab.plugin.zsh
  zstyle ':completion:*' menu no
  zstyle ':fzf-tab:*' fzf-flags --color=fg:1,fg+:2 --bind=tab:accept
  zstyle ':fzf-tab:*' switch-group '<' '>'
  zstyle ':completion:*:descriptions' format '[%d]'

  zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls -vF --color --group-directories-first $realpath'
  zstyle ':fzf-tab:complete:ls:*' fzf-preview 'ls -vF --color --group-directories-first $realpath'
  zstyle ':fzf-tab:complete:(-command-|-parameter-|-brace-parameter-|export|unset|expand):*' fzf-preview 'echo ${(P)word}'

  # give a preview of commandline arguments when completing `kill`
  zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"
  zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-preview '[[ $group == "[process ID]" ]] && ps --pid=$word -o cmd --no-headers -w -w'
  zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-flags --preview-window=down:3:wrap

  #git
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
fi

# === SYNTAX HIGHLIGHTING ===
# zplug zsh-syntax-highlighting/zsh-syntax-highlighting.zsh # Must be sourced near last
# ZSH_HIGHLIGHT_HIGHLIGHTERS+=(brackets)

# === FAST SYNTAX HIGHLIGHTING ===
zplug fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
FAST_HIGHLIGHT[use_brackets]=1

# === AUTO SUGGESTIONS ===
zplug zsh-autosuggestions/zsh-autosuggestions.zsh

# === SUBSTRING SEARCH ===
zplug zsh-history-substring-search/zsh-history-substring-search.zsh
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# =====================================================================
# FINIALIZATION
# =====================================================================

[[ "$ZPROF" == 1 ]] && zprof

true #make that arrow nice and green
