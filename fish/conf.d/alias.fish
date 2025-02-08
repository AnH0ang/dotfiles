# shorten long commands
abbr c cd
abbr g git
abbr kc kubectl
abbr l eza
abbr lg lazygit
abbr o code .
abbr yy yazi

# git commands
abbr gp git push
abbr gc git commit
abbr ga git amend
abbr gau git autocommit
abbr gs git status
abbr gl git log
abbr gd git diff

# tools replacements
abbr cat bat
abbr convert magick
abbr du "dust --depth 1"
abbr exa eza
abbr grep rg
abbr jq yq
abbr lf yazi
abbr ls eza
abbr neofetch fastfetch
abbr npm pnpm
abbr pipx "uv tool"
abbr ps procs
abbr ranger yazi
abbr tree "eza --tree"
abbr vi nvim
abbr vim nvim

# new commands
abbr benchmark hyperfine
abbr help "aichat -r shell:zsh"
abbr shred "rm -P"
abbr view "nvim -R"

# Colorize commands when possible.
alias diff="diff --color=auto"
alias grep="grep --color=auto"
alias less="less -R"
alias ls="ls -G"
