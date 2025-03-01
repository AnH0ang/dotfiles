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
    bind dd "fish_clipboard_copy; commandline -f kill-whole-line"
    bind p fish_clipboard_paste
    bind -M visual y "fish_clipboard_copy; commandline -f end-selection repaint-mode"
    bind -M visual x "fish_clipboard_copy; commandline -f kill-selection end-selection repaint-mode"
    bind -M visual d "fish_clipboard_copy; commandline -f kill-selection end-selection repaint-mode"

    # selection
    bind -M insert ctrl-f forward-char
    bind -M insert ctrl-b backward-char
    bind -M insert ctrl-n down-or-search
    bind -M insert ctrl-p up-or-search
    bind -M insert ctrl-u fcmd

    # aliases
    bind -M insert ctrl-l yazi-cd
    bind -M insert ctrl-o z-cd
    bind -M insert ctrl-g fzf-cd
    bind -M insert ctrl-e edit_command_buffer
end
