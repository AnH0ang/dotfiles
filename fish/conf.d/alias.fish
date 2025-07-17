# cd
abbr .. "cd ../"
abbr ... "cd ../../"
abbr .... "cd ../../../"
abbr ..... "cd ../../../../"
abbr ...... "cd ../../../../../"

# shorten long commands
abbr gg fgrep
abbr kc kubectl
abbr lg lazygit
abbr tf tofu
abbr j just

# git commands
abbr ga git amend
abbr gau git autocommit
abbr gc git commit
abbr gd git diff
abbr gl git log
abbr gp git push
abbr gs git status

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
abbr sed sd
abbr tree "eza --tree"
abbr vi nvim
abbr vim nvim
abbr upgrade topgrade
abbr terraform tofu

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
