function fzf-cd
    set fd_opts "--hidden --exclude .git"
    set preview_dir "eza --icons --group-directories-first {}"
    set preview_file "bat --plain --theme ansi --force-colorization {}"
    set path_or_file (
        fd . $fd_options |
        fzf \
            --header 'CTRL-D: Directories / CTRL-F: Files' \
            --preview 'test -d {} && '"$preview_dir"' || '"$preview_file" \
            --bind "ctrl-d:reload(fd --type d $fd_opts)+change-prompt(Directories> )" \
            --bind "ctrl-f:reload(fd --type f $fd_opts)+change-prompt(Files> )" \
    )

    if test -f "$path_or_file"
        cd (dirname "$path_or_file")
    else if test -d "$path_or_file"
        cd "$path_or_file"
    end
    commandline -f repaint
end
