# cd
abbr .. "cd ../"
abbr ... "cd ../../"
abbr .... "cd ../../../"
abbr ..... "cd ../../../../"
abbr ...... "cd ../../../../../"

# shorten long commands
abbr kc kubectl
abbr lg lazygit

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
abbr less delta
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
abbr sd sed

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
