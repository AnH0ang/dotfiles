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

    if command -q gcloud
        complete -c gcloud -f -a '(__fish_argcomplete_complete gcloud)'
        complete -c gsutil -f -a '(__fish_argcomplete_complete gsutil)'
    end

    # See https://github.com/microsoft/vscode/issues/208465
    if test "$TERM_PROGRAM" = vscode
        . (code --locate-shell-integration-path fish)
    end

    fish_vi_key_bindings

    bind -M insert \cf forward-char
    bind -M insert \cb backward-char
    bind -M insert \cn down-or-search
    bind -M insert \cp up-or-search

    bind -M insert \cl yazi-cd
    bind -M insert \co z-cd
    bind -M insert \cg fzf-cd
    bind -M insert \ce edit_command_buffer
end
