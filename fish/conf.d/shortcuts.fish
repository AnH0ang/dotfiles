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

function yazi-cd
    yazi --cwd-file /tmp/yazi-cwd;
    cd (cat /tmp/yazi-cwd);
    commandline -f repaint;
end

function z-cd
    cd (zoxide query --interactive);
    commandline -f repaint;
end

function fgrep
    rg --color=always --line-number --no-heading --smart-case $argv |
        fzf --ansi \
            --color "hl:-1:underline,hl+:-1:underline:reverse" \
            --delimiter : \
            --preview 'bat --theme ansi --color always {1} --highlight-line {2}' \
            --preview-window 'up,60%,border-bottom,+{2}+3/3,~3'
end