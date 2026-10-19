# ~/.config/fish/config.fish

# uv
set -gx UV_SYSTEM_CERTS 1

# pnpm
set -gx PNPM_HOME $HOME/.local/share/pnpm
fish_add_path -g $PNPM_HOME/bin        # fish_add_path skips duplicates itself

# SDKMAN: add the "current" bin dir of each installed tool to PATH
set -gx SDKMAN_DIR $HOME/.sdkman
for dir in $SDKMAN_DIR/candidates/*/current/bin
    fish_add_path -g $dir
end
test -d $SDKMAN_DIR/candidates/java/current
and set -gx JAVA_HOME $SDKMAN_DIR/candidates/java/current

# NVM (see notes: nvm.sh itself does not work in fish)
set -gx NVM_DIR $HOME/.nvm
