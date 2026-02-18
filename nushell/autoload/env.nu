# Locale
$env.LC_ALL = "en_US.UTF-8"

# Local scripts
$env.PATH = ($env.PATH | prepend $"($env.HOME)/.config/bin")

# XDG settings
$env.XDG_CONFIG_HOME = $"($env.HOME)/.config"
$env.XDG_DATA_HOME = $"($env.HOME)/.local/share"
$env.XDG_CACHE_HOME = $"($env.HOME)/.cache"

# cd
$env.CDPATH = $"($env.HOME)"

# Defaults
$env.VISUAL = "nvim"
$env.EDITOR = "nvim"
$env.GIT_EDITOR = "nvim"

# less
$env.LESSHISTFILE = "-"

# readline
$env.INPUTRC = $"($env.XDG_CONFIG_HOME)/readline/.inputrc"

# fzf
$env.FZF_DEFAULT_COMMAND = "fd --type f --hidden --exclude .git --max-depth 4"

# starship
$env.STARSHIP_CONFIG = $"($env.XDG_CONFIG_HOME)/starship/starship.toml"

# pipx / local bin
$env.PATH = ($env.PATH | prepend $"($env.HOME)/.local/bin")

# python
$env.PYTHONSTARTUP = $"($env.XDG_CONFIG_HOME)/python/startup.py"

# aichat
$env.AICHAT_CONFIG_DIR = $"($env.XDG_CONFIG_HOME)/aichat"

# homebrew
$env.HOMEBREW_NO_ENV_HINTS = "1"
$env.HOMEBREW_PREFIX = "/opt/homebrew"
$env.HOMEBREW_CELLAR = "/opt/homebrew/Cellar"
$env.HOMEBREW_REPOSITORY = "/opt/homebrew"
$env.PATH = ($env.PATH | prepend ["/opt/homebrew/sbin", "/opt/homebrew/bin"])
$env.MANPATH = ($env.MANPATH? | default [] | prepend "/opt/homebrew/share/man")
$env.INFOPATH = ($env.INFOPATH? | default [] | prepend "/opt/homebrew/share/info")
$env.HOMEBREW_NO_AUTO_UPDATE = "1"

# python venv
$env.VIRTUAL_ENV_DISABLE_PROMPT = "true"

# rust
$env.PATH = ($env.PATH | prepend $"($env.HOME)/.cargo/bin")

# mise
$env.MISE_ENV_FILE = ".env"
