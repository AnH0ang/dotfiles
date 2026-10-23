# vscode
rm -f "${HOME}/.vscode-server/data/Machine/settings.json"
ln -sf "${HOME}/.config/vscode/settings.jsonc" "${HOME}/.vscode-server/data/Machine/settings.json"
rm -f "${HOME}/.vscode-server/data/Machine/keybindings.json"
ln -sf "${HOME}/.config/vscode/keybindings.jsonc" "${HOME}/.vscode-server/data/Machine/keybindings.json"

# Gemini
rm -f "${HOME}/.gemini/GEMINI.md"
ln -sf "${HOME}/.config/gemini/GEMINI.md" "${HOME}/.gemini/GEMINI.md"
rm -f "${HOME}/.gemini/settings.json"
ln -sf "${HOME}/.config/gemini/settings.json" "${HOME}/.gemini/settings.json"

# Remove system uv
rm -f ~/.local/bin/uv ~/.local/bin/uvx

# Install file
sudo apt update 
sudo apt install --yes file
