def --env z-cd [] {
    let path = (zoxide query --interactive | str trim)
    if ($path | is-not-empty) {
        cd $path
    }
}

def --env yazi-cd [] {
    yazi --cwd-file /tmp/yazi-cwd
    let path = (open /tmp/yazi-cwd | str trim)
    if ($path | is-not-empty) {
        cd $path
    }
}
