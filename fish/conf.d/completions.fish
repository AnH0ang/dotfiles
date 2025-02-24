set -l completions_dir "$HOME/.config/fish/completions"
if not test -d "$completions_dir"
    mkdir -p "$completions_dir"
end

if command -q ruff
    set cache_file "$completions_dir/ruff.fish"
    if not test -f "$cache_file"
        ruff generate-shell-completion fish >"$cache_file"
    end
end

if command -q poetry
    set cache_file "$completions_dir/poetry.fish"
    if not test -f "$cache_file"
        poetry completions fish >"$cache_file"
    end
end

if command -q aichat
    set cache_file "$completions_dir/aichat.fish"
    if not test -f "$cache_file"
        curl https://raw.githubusercontent.com/sigoden/aichat/main/scripts/completions/aichat.fish >"$cache_file"
    end
end
