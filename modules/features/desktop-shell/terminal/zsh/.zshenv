# ======================
# ||  ==> ZSHENV <==  ||
# ======================

# =====================================================================
# SYSTEM CORE ENVIRONMENTS (XDG BASE DIRECTORY COMPLIANCE)
# =====================================================================

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

# =====================================================================
# APPLICATION INTERACTIVE PATH ROUTING
# =====================================================================
export ZDOTDIR="/home/mckahz/.dotfiles/modules/features/desktop-shell/terminal/zsh"
export ZCACHEDIR="$XDG_CACHE_HOME/zsh"
export ZPLUGINDIR="$ZDOTDIR/plugins"
export GOPATH="$XDG_DATA_HOME/go"
export GOMODCACHE="$XDG_CACHE_HOME/go/pkg/mod"

export EDITOR="vim"
export VISUAL="$EDITOR"
export PAGER="less"
export MANPAGER="$PAGER"
export GCM_CREDENTIAL_STORE="pass"
export GPG_TTY="$TTY"
