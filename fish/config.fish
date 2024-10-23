set -g fish_greeting

if status is-interactive
    set fish_cursor_default block
    set fish_cursor_insert line
    set fish_cursor_replace_one underscore
    set fish_cursor_visual block

    starship init fish | source
    zoxide init fish | source
    atuin init fish --disable-up-arrow | source
    mise activate fish | source
    direnv export fish | source

    fish_vi_key_bindings
    bind -M insert \cn down-or-search
    bind -M insert \cp up-or-search
    bind -M insert \cl yazi-cd
    bind -M insert \co z-cd
    bind -M insert \cg fzf-cd
    bind -M insert \cf accept-autosuggestion
    bind -M insert \ce edit_command_buffer
end
