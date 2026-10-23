function frg --description 'ripgrep -> fzf -> VS Code'
    # Note: these strings are run by bash (see --with-shell), not by fish
    set -l RELOAD 'reload:rg --column --color=always --smart-case {q} || :'
    set -l OPENER 'cut -d: -f1-3 {+f} | xargs -d "\n" code -g'

    fzf --disabled --ansi --multi \
        --with-shell 'bash -c' \
        --bind "start:$RELOAD" --bind "change:$RELOAD" \
        --bind "enter:become:$OPENER" \
        --bind "ctrl-o:execute:$OPENER" \
        --bind 'alt-a:select-all,alt-d:deselect-all,ctrl-/:toggle-preview' \
        --delimiter : \
        --preview 'bat --style=full --color=always --highlight-line {2} {1}' \
        --preview-window '~4,+{2}+4/3,<80(up)' \
        --query "$argv"
end
