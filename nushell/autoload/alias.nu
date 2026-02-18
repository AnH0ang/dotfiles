# cd shortcuts
alias .. = cd ..
alias ... = cd ../..
alias .... = cd ../../..
alias ..... = cd ../../../..
alias ...... = cd ../../../../..

# shorten long commands
alias gg = fgrep
alias kc = kubectl
alias lg = lazygit
alias tf = terraform
alias j = just

# git commands
alias ga = git amend
alias gau = git autocommit
alias gc = git commit
alias gd = git diff
alias gl = git log
alias gp = git push
alias gs = git status

# tool replacements
alias cat = bat
alias convert = magick
alias du = dust --depth 1
alias exa = eza
alias grep = rg
alias jq = yq
alias less = delta
alias lf = yazi
alias neofetch = fastfetch
alias pipx = uv tool
alias ps = procs
alias ranger = yazi
alias sed = sd
alias tree = eza --tree
alias vi = nvim
alias vim = nvim
alias upgrade = topgrade
alias pnpx = pnpm dlx

# new commands
alias benchmark = hyperfine
alias help = aichat -r shell:zsh
alias view = nvim -R

# colorized commands
alias diff = diff --color=auto
alias less = less -R
