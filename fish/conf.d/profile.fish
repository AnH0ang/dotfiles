set -x LC_ALL "en_US.UTF-8"

# local scripts
set -x PATH $PATH $HOME/.config/bin

# xdg settings
set -x XDG_CONFIG_HOME "$HOME/.config"
set -x XDG_DATA_HOME "$HOME/.local/share"
set -x XDG_CACHE_HOME "$HOME/.cache"

# cd
set -x CDPATH $CDPATH $HOME

# defaults
set -x VISUAL nvim
set -x EDITOR nvim
set -x GIT_EDITOR nvim

# less
set -x LESSHISTFILE -

# readline
set -x INPUTRC "$XDG_CONFIG_HOME/readline/.inputrc"

# fzf
set -x FZF_DEFAULT_COMMAND "fd --type f --hidden --exclude .git --max-depth 4"

# starship
set -x STARSHIP_CONFIG "$XDG_CONFIG_HOME/starship/starship.toml"

# pipx
set -x PATH "$HOME/.local/bin" $PATH

# python
set -x PYTHONSTARTUP "$XDG_CONFIG_HOME/python/startup.py"

# aichat
set -x AICHAT_CONFIG_DIR "$XDG_CONFIG_HOME/aichat"

# homebrew
set -x HOMEBREW_NO_ENV_HINTS 1
set -x HOMEBREW_PREFIX /opt/homebrew
set -x HOMEBREW_CELLAR /opt/homebrew/Cellar
set -x HOMEBREW_REPOSITORY /opt/homebrew
set -x PATH /opt/homebrew/bin /opt/homebrew/sbin $PATH
set -x MANPATH /opt/homebrew/share/man $MANPATH
set -x INFOPATH /opt/homebrew/share/info $INFOPATH

# python venv
set -x VIRTUAL_ENV_DISABLE_PROMPT true

# poetry
set -x POETRY_CONFIG_DIR "$XDG_CONFIG_HOME/poetry"

# rye
set -x RYE_HOME "$XDG_CONFIG_HOME/rye"
set -x PATH "$HOME/.config/rye/shims" $PATH

# rust
set -x PATH "$HOME/.cargo/bin" $PATH

# direnv
set -x DIRENV_LOG_FORMAT ""

# tex
set -x PATH /Library/TeX/texbin $PATH
