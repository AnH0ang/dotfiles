#            _
#    _______| |__  _ __ ___
#   |_  / __| '_ \| '__/ __|
#  _ / /\__ \ | | | | | (__
# (_)___|___/_| |_|_|  \___|

# install tmux plugin manager if not exists
if [ ! -d "$HOME/.config/tmux/plugins/tpm" ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
    sh ~/.config/tmux/plugins/tpm/scripts/install_plugins.sh
fi

# install zgen if not exists
ZGEN_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zgen"
[ ! -d $ZGEN_HOME ] && git clone https://github.com/tarjoilija/zgen.git "${ZGEN_HOME}"
source "${ZGEN_HOME}/zgen.zsh"

# if the init script doesn't exist
if ! zgen saved; then
    zgen load zsh-users/zsh-autosuggestions
    zgen load zsh-users/zsh-syntax-highlighting
    zgen load kutsan/zsh-system-clipboard
    zgen load zsh-users/zsh-completions
    zgen load zsh-users/zsh-history-substring-search
    zgen load hlissner/zsh-autopair
    zgen oh-my-zsh plugins/vi-mode
    zgen save
fi

# load aliases and shortcuts if existent.
[ -f "$HOME/.config/shell/shortcutrc" ] && source "$HOME/.config/shell/shortcutrc"
[ -f "$HOME/.config/shell/aliasrc" ] && source "$HOME/.config/shell/aliasrc"

# setup completion
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
autoload -Uz compinit bashcompinit
zstyle ':completion:*' menu select
zstyle ':completion:*:make:*:targets' call-command true
zmodload zsh/complist
fpath+=($HOMEBREW_PREFIX/share/zsh/site-functions)
compinit
bashcompinit

# vi-mode enable cursor
export VI_MODE_SET_CURSOR=true

# Use vim keys in tab complete menu:
bindkey -M menuselect '^B' vi-backward-char
bindkey -M menuselect '^U' vi-up-line-or-history
bindkey -M menuselect '^F' vi-forward-char
bindkey -M menuselect '^D' vi-down-line-or-history

# generate init file and run it
local init_file="${HOME}/.config/zsh/init.zsh"
[[ -f "$init_file" ]] || {
    [[ $(command -v starship) ]] && (starship init zsh >>"$init_file") || true
    [[ $(command -v mise) ]] && (mise activate zsh >>"$init_file") || true
    [[ $(command -v zoxide) ]] && (zoxide init zsh >>"$init_file") || true
    [[ $(command -v atuin) ]] && (atuin init zsh --disable-up-arrow >>"$init_file") || true
}
source "$init_file"

# keybindings
bindkey -s '^o' 'fz\n'
bindkey -s '^g' 'fcd\n'
bindkey -s '^l' 'ycd\n'
bindkey '^f' autosuggest-accept
bindkey '^e' edit-command-line
