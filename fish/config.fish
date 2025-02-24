set -g fish_greeting

if status is-interactive
    set fish_cursor_default block
    set fish_cursor_insert line
    set fish_cursor_replace_one underscore
    set fish_cursor_visual block

    if command -q zoxide
        zoxide init fish | source
    end

    if command -q atuin
        atuin init fish --disable-up-arrow | source
    end

    if command -q mise
        mise activate fish | source
    end

    if command -q starship
        starship init fish | source
    end

    # See https://github.com/microsoft/vscode/issues/208465
    if test "$TERM_PROGRAM" = vscode
        . (code --locate-shell-integration-path fish)
    end

    # vim
    fish_vi_key_bindings
    bind yy fish_clipboard_copy
    bind Y fish_clipboard_copy
    bind p fish_clipboard_paste
    bind -M visual y "fish_clipboard_copy; commandline -f end-selection repaint-mode"

    # selection
    bind -M insert \cf forward-char
    bind -M insert \cb backward-char
    bind -M insert \cn down-or-search
    bind -M insert \cp up-or-search

    # aliases
    bind -M insert \cl yazi-cd
    bind -M insert \co z-cd
    bind -M insert \cg fzf-cd
    bind -M insert \ce edit_command_buffer
end
