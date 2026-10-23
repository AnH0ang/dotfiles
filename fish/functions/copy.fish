function copy --description 'Copy stdin or arguments to the host clipboard via OSC 52'
    begin
        printf '\e]52;c;'
        if set -q argv[1]
            printf '%s' "$argv" | base64 | tr -d '\n'
        else
            base64 | tr -d '\n'
        end
        printf '\a'
    end > /dev/tty
end
