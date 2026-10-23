function dumpfiles --description 'Print files as fenced blocks with a relative-path header'
    if test (count $argv) -eq 0
        echo "usage: dumpfiles PATH..." >&2
        return 1
    end

    # Collect all files (recursing into directories)
    set -l candidates
    for arg in $argv
        if test -d $arg
            set -a candidates (find $arg -name .git -prune -o -type f -print | sort)
        else if test -f $arg
            set -a candidates $arg
        else
            echo "dumpfiles: skipping '$arg' (not found)" >&2
        end
    end

    set -l seen
    set -l first 1

    for f in $candidates
        # Build path relative to cwd
        set -l abs $f
        string match -q -- '/*' $f; or set abs $PWD/$f
        set abs (path normalize -- $abs)

        set -l rel
        if string match -q -- "$PWD/*" $abs
            set rel (string replace -- "$PWD/" "" $abs)
        else
            set rel (realpath --relative-to=$PWD -- $abs 2>/dev/null; or echo $abs)
        end

        # De-duplicate
        contains -- $rel $seen; and continue
        set -a seen $rel

        # Skip binary files
        if test -s $f; and not grep -Iq '' -- $f
            echo "dumpfiles: skipping binary file '$rel'" >&2
            continue
        end

        # Fence: 4 backticks, or longer if the file itself contains 4+ in a row
        set -l fence '`````'
        set -l longest (grep -oE '`+' -- $f | awk '{ if (length > m) m = length } END { print m+0 }')
        if test $longest -ge 4
            set fence (string repeat -n (math $longest + 1) '`')
        end

        # Blank line between entries
        test $first -eq 1; or echo
        set first 0

        echo "# file: $rel"
        echo $fence
        cat -- $f
        # Make sure the closing fence is on its own line
        if test -s $f; and test (tail -c1 -- $f | od -An -tx1 | string trim) != 0a
            echo
        end
        echo $fence
    end
end
