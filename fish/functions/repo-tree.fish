function repo-tree --description 'Show outermost Git repositories as a tree'
    set -l dir .
    set -q argv[1]; and set dir $argv[1]

    # Find .git entries relative to $dir, strip ".git" (keep trailing "/"), sort.
    set -l repos (fd --base-directory $dir --hidden --no-ignore --prune \
        --exclude '*__worktrees' '^\.git$' |
        string replace -r '\.git/?$' '' | sort)
    or return 1

    # Keep only outermost repos. After sorting, nested repos come right after their parent.
    set -l outermost
    set -l last
    for repo in $repos
        if test -n "$last"; and string match -q -- "$last*" $repo
            continue
        end
        set -a outermost $repo
        set last $repo
    end

    # Recreate just the repo folders in a temp dir and draw the tree.
    set -l view (mktemp -d)
    for repo in $outermost
        mkdir -p $view/$repo
    end

    pushd $view
    eza --tree --all --color=never --icons=never .
    popd
    command rm -rf $view
end
