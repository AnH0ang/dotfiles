function fworkmux --description 'fzf picker for workmux worktrees'
    # Hidden fields: 1 handle | 2 path | 3 is_main
    # Shown fields:  4 handle | 5 branch | 6 flags
    set -l jq_prog '
        def pad(n): tostring | if length > n then .[0:n-1] + "…" else . + (" " * (n - length)) end;
        sort_by((.is_main | not), -(.created_at // 0))[]
        | [ .handle, .path, (.is_main | tostring),
            (.handle | pad(28)),
            ((.branch // "-") | pad(30)),
            ( (if .is_main then "★" else "" end)
            + (if .is_open then "●" else "" end)
            + (if .has_uncommitted_changes then "✚" else "" end) )
          ] | @tsv'

    while true
        set -l out (workmux list --json | jq -r $jq_prog | fzf \
            --multi --delimiter \t --with-nth 4,5,6 \
            --layout reverse --height 80% --border --prompt 'workmux> ' \
            --header 'enter: open   ctrl-o: cd   alt-e: VS Code   ctrl-x: remove' \
            --preview 'git -C {2} -c color.ui=always status -sb; echo; git -C {2} log --oneline --color=always -15' \
            --expect ctrl-o,ctrl-x,alt-e)
        or return 0
        test (count $out) -ge 2; or return 0

        set -l key $out[1]
        set -l sel $out[2..-1]
        set -l f (string split \t -- $sel[1])

        switch $key
            case ''        # enter
                workmux open $f[1]
                return

            case ctrl-o
                cd $f[2]
                return

            case alt-e
                if not command -q code
                    echo "fworkmux: 'code' not found in PATH" >&2
                    return 1
                end
                for line in $sel
                    code (string split -f2 \t -- $line)
                end
                return

            case ctrl-x
                for line in $sel
                    set -l e (string split \t -- $line)
                    if test "$e[3]" = true
                        echo "Skipping main worktree '$e[1]'"
                        continue
                    end
                    workmux remove $e[1]
                end
                # The list then reopens with fresh data
        end
    end
end
