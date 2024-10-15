set -g fish_greeting


function yazi-cd
    yazi --cwd-file /tmp/yazi-cwd;
    cd (cat /tmp/yazi-cwd);
    commandline -f repaint;
end

function z-cd
    cd (zoxide query --interactive);
    commandline -f repaint;
end

if status is-interactive
    starship init fish | source
    zoxide init fish | source
    atuin init fish --disable-up-arrow | source
    mise activate fish | source

    bind -M insert \cn down-or-search
    bind -M insert \cp up-or-search

    bind -M insert \cl yazi-cd
    bind -M insert \co z-cd
    bind -M insert \cf accept-autosuggestion
    bind -M insert \ce edit_command_buffer

    fish_vi_key_bindings
end

