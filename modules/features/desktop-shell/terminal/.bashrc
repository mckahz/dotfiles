# =====================
# ||  ==> BASHRC <== ||
# =====================

# =====================================================================
# INITIALIZATION
# =====================================================================

# === Interactivity check ===
[[ $- != *i* ]] && return

# === XDG Base Directory Compliance ===
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_BIN_HOME="${XDG_BIN_HOME:-$HOME/.local/bin}"

export XDG_DESKTOP_DIR="${XDG_DESKTOP_DIR:-$HOME/Desktop}"
export XDG_DOWNLOAD_DIR="${XDG_DOWNLOAD_DIR:-$HOME/Downloads}"
export XDG_DOCUMENTS_DIR="${XDG_DOCUMENTS_DIR:-$HOME/Documents}"
export XDG_MUSIC_DIR="${XDG_MUSIC_DIR:-$HOME/Music}"
export XDG_PICTURES_DIR="${XDG_PICTURES_DIR:-$HOME/Pictures}"
export XDG_VIDEOS_DIR="${XDG_VIDEOS_DIR:-$HOME/Videos}"
export XDG_PUBLICSHARE_DIR="${XDG_PUBLICSHARE_DIR:-$HOME/Public}"
export XDG_TEMPLATES_DIR="${XDG_TEMPLATES_DIR:-$HOME/Templates}"

# === Path Check ===
_pathcheck() { [[ -d ${2} ]] || mkdir -p ${2}; export ${1}=${2}; }

_pathcheck BASHSTATE "${XDG_STATE_HOME}/bash"
_pathcheck VIMSTATE "${XDG_STATE_HOME}/vim"
_pathcheck GOPATH "${XDG_DATA_HOME}/go"
_pathcheck GOMODCACHE "${XDG_CACHE_HOME}/go/pkg/mod"

# === Clean Up ===
[[ -f "${HOME}/.bash_history" ]] && rm "${HOME}/.bash_history"
[[ -f "${HOME}/.viminfo" ]] && rm "${HOME}/.viminfo"

# =====================================================================
# GENERAL
# =====================================================================

shopt -s autocd cdspell checkwinsize cmdhist extglob globstar nocaseglob histappend lithist
shopt -s dirspell 2>/dev/null

export EDITOR="vim"
export VISUAL="$EDITOR"
export PAGER="less"
export MANPAGER="$PAGER"
export GCM_CREDENTIAL_STORE="pass"
export GPG_TTY="$TTY"

# === PROMPT ===
export PROMPT_DIRTRIM=3
PS1='\[\e[1;33m\]-- \u@\h \w --\[\e[0m\]\n\[\e[1;34m\]>>> \[\e[0m\]'

# === Tooling Colors ===
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# =====================================================================
# KEYBINDS (Vi Mode)
# =====================================================================

set -o vi
export KEYTIMEOUT=1

# === General Bindings ===
bind '"\C-r": reverse-search-history'
bind '" ": magic-space'

# === History Search (Arrow Keys) ===
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# === Command Mode (vicmd) ===
bind -m vi-command '"U": redo'
bind -m vi-command '"k": history-search-backward'
bind -m vi-command '"j": history-search-forward'

# =====================================================================
# TAB COMPLETION SETTINGS
# =====================================================================

bind 'set completion-ignore-case on'
bind 'set show-all-if-ambiguous on'
bind 'set mark-directories on'
bind 'set menu-complete-display-prefix on'
bind 'TAB:menu-complete'
bind '"\e[Z": menu-complete-backward'

# === Include Hidden Files ===
shopt -s dotglob

# =====================================================================
# HISTORY CONFIGURATION
# =====================================================================

export HISTFILE="${BASHSTATE}/history"
HISTSIZE=10000
HISTFILESIZE=10000

# === Set Options ===
export HISTCONTROL=ignoreboth:erasedups
export HISTTIMEFORMAT="%F %T "

# === Share History Across Sessions ===
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# =====================================================================
# ALIASES
# =====================================================================

# === Useful ===
alias shrc='${EDITOR} "$HOME/.bashrc"'
alias loadsh='source "$HOME/.bashrc"'
alias bye='read -r -p "Really power off? [Y/n] " REPLY || exit; [[ -z $REPLY || $REPLY == [Yy]* ]] && sudo poweroff || echo "Shutdown cancelled."'
alias arch='proot-distro login archlinuxarm --user glhuun --shared-tmp'

# === Set Default Flags/Options ===
alias ls='ls -vF --color=auto --group-directories-first'
alias lsa='ls -A'
alias grep='grep -C1 -i --color=auto --group-separator="*===========================/ (...^. .^..) /===========================*"'
alias bat='bat -P --theme="ansi"'
alias info="info --vi-keys -v link-style=blue,underline -v active-link-style=cyan,underline,bold -v match-style=bgyellow,black"

# === Directory Navigation ===
alias home='cd "$HOME" && ls'
alias root='cd / && ls'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# === Alt Names & Typo Helpers ===
alias cleart='clear'
alias cleat='clear'
alias claer='clear'

# =====================================================================
# CUSTOM FUNCTIONS
# =====================================================================

# === CD With Yazi (bound to CTRL+O) ===
function yazicd() {
  local tmp cwd
  tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
  command yazi "$@" --cwd-file="$tmp"
  IFS= read -r -d '' cwd <"$tmp"
  [ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd" || builtin true
  command rm -f -- "$tmp"
}
bind '"\C-o": "\C-uyazicd\n"'

# === Ez Extractions ===
extract() {
  if [[ "$1" == "help" || "$1" == "-h" || -z "$1" ]]; then
    echo "[extract]: Universal archive extractor."
    echo "Usage: extract <archive> [archive...]"
    return 0
  fi

  for file in "$@"; do
    if [[ -f "$file" ]]; then
      echo "Extracting '$file'..."
      case "$file" in
      *.tar.bz2 | *.tbz2) tar xjf "$file" ;;
      *.tar.gz | *.tgz) tar xzf "$file" ;;
      *.bz2) bunzip2 "$file" ;;
      *.rar) command -v unrar &>/dev/null && unrar x "$file" || echo "unrar utility not found." ;;
      *.gz) gunzip "$file" ;;
      *.tar) tar xf "$file" ;;
      *.zip) unzip "$file" ;;
      *.Z) uncompress "$file" ;;
      *.7z) command -v 7z &>/dev/null && 7z x "$file" || echo "7z utility not found." ;;
      *) echo "[!] '$file' cannot be extracted via extract()." ;;
      esac
    else
      echo "[!] '$file' is not a valid file."
    fi
  done
}

# =====================================================================
# PACKAGE GUARD RAILS & WRAPPERS
# =====================================================================

sudo() {
  [[ "${@:1:2}" == "pacman -Sy" ]] && { echo "WARNING: risky flags detected! Use \"-Syu\""; return 1; }

  [[ "${*:1:2}" == "pacman "@("autoremove"|"-Yc") ]] && {
      local orphans; mapfile -t orphans < <(command pacman -Qtdq 2>/dev/null)
      (( ${#orphans[@]} )) && command sudo pacman -Rns "${orphans[@]}" || echo "No orphaned packages found to remove."
      return; }

  [[ "$1" == "vim" ]] && { command sudo -E "$@"; return; }

  command sudo "$@"
}

_pacwrap() {
  local cmd="$1" && shift

  [[ "$1" == "-Sy" ]] && { echo "WARNING: risky flags detected! Use '-Syu' instead."; return 1; }

  [[ "$1" == @("autoremove"|"-Yc") ]] && {
      local orphans; mapfile -t orphans < <(command "$cmd" -Qtdq 2>/dev/null)
      (( ${#orphans[@]} )) && command "$cmd" -Rns "${orphans[@]}" || echo "No orphaned packages found to remove."
      return; }

  command "$cmd" "$@"
}

pacman() { _pacwrap "pacman" "$@"; }
yay()    { _pacwrap "yay" "$@"; }
