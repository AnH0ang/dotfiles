function fcmd --description 'search available commands'
    set chosen_command (
        begin
            functions;
            abbr --list;
            for p in $PATH
                if test -d $p
                    fd . "$p" --max-depth 1 --follow --type x --exec basename;
                end
            end
        end |
        nodup |
        fzf)

    commandline -i $chosen_command
end
