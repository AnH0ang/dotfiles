#!/usr/bin/fish

function replace-all --description "Search and replace in file contents and filenames recursively"
    if test (count $argv) -ne 2
        echo "Usage: replace-all <search> <replace>"
        return 1
    end

    set search $argv[1]
    set replace $argv[2]

    # Replace in file contents
    for file in (fd . --type f)
        sd $search $replace $file
    end

    # Replace in filenames and directory names
    for old_path in (fd . --type f)
        set new_path (string replace -a "$search" "$replace" "$old_path")
        if test "$old_path" != "$new_path"
            mkdir -p (dirname "$new_path")
            mv -f "$old_path" "$new_path"
        end
    end
end
