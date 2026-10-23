function dumpfiles --description 'Print files with a relative-path header, separated by ---'
    if test (count $argv) -eq 0
        echo "usage: dumpfiles PATH..." >&2
        return 1
    end

    # Collect all files (recursing into directories)
    set -l candidates
    for arg in $argv
        if test -d $arg
            # Skip .git directories; sort for stable output
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
        # Build path relative to cwd (no symlink resolution)
        set -l abs $f
        string match -q -- '/*' $f; or set abs $PWD/$f
        set abs (path normalize -- $abs)

        set -l rel
        if string match -q -- "$PWD/*" $abs
            set rel (string replace -- "$PWD/" "" $abs)
        else
            set rel (realpath --relative-to=$PWD -- $abs 2>/dev/null; or echo $abs)
        end

        # De-duplicate (e.g. "src" and "src/main.c" both given)
        contains -- $rel $seen; and continue
        set -a seen $rel

        # Skip binary files (non-empty files that grep considers binary)
        if test -s $f; and not grep -Iq '' -- $f
            echo "dumpfiles: skipping binary file '$rel'" >&2
            continue
        end

        if test $first -eq 1
            echo '---'
            set first 0
        end

        echo "# file: $rel"
        echo
        cat -- $f
        # Add a newline if the file doesn't end with one
        if test -s $f; and test (tail -c1 -- $f | od -An -tx1 | string trim) != 0a
            echo
        end
        echo '---'
    end
end
