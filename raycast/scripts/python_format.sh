#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Format Python in Clipboard
# @raycast.mode fullOutput

# Optional parameters:
# @raycast.icon 👔
# @raycast.packageName Format Python

# Check if ruff is installed
if ! command -v ~/.local/bin/ruff &>/dev/null; then
    echo "Error: ruff is not installed"
    echo "Please install it using: uv tool install ruff"
    exit 1
fi

# Extract the text from the clipboard, remove any leading '%' characters, and format the text
percent_lines=$(pbpaste | grep '^%')
formatted_out=$(pbpaste | grep -v '^%' | ~/.local/bin/ruff format - | ~/.local/bin/ruff check --fix -)

# Output the formatted text
if [ -n "$percent_lines" ]; then
    echo -e "$percent_lines\n$formatted_out" | pbcopy
    echo -e "$percent_lines\n$formatted_out"
else
    echo "$formatted_out" | pbcopy
    echo "$formatted_out"
fi
