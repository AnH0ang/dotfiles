function fgrep
    set root $argv[1]

    if test -z "$root"
        set root "."
    end

    rg --color=always --line-number --no-heading --smart-case $root |
        fzf --ansi \
            --color "hl:-1:underline,hl+:-1:underline:reverse" \
            --delimiter : \
            --preview 'bat --theme ansi --color always {1} --highlight-line {2}' \
            --preview-window 'up,60%,border-bottom,+{2}+3/3,~3'
end
