function zcd
    set path (zoxide query --interactive);
    if test -n "$path"
        cd $path;
    end

    commandline -f repaint;
end
