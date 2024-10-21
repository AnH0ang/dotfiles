function yazi-cd
    yazi --cwd-file /tmp/yazi-cwd;
    cd (cat /tmp/yazi-cwd);
    commandline -f repaint;
end
