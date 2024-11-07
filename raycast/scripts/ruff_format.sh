#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Ruff Format Clipboard
# @raycast.mode fullOutput

# Optional parameters:
# @raycast.icon 👔
# @raycast.packageName Writing

# Extract the text from the clipboard, remove any leading '%' characters, and format the text
percent_lines=$(pbpaste | grep '^%')
formatted_out=$(pbpaste | grep -v '^%' | ~/.local/bin/ruff format -)

echo -e "Formatted text copied to clipboard:"
echo -e "-----------------------------------\n"

# Output the formatted text
if [ -n "$percent_lines" ]; then
    echo -e "$percent_lines\n$formatted_out" | pbcopy
    echo -e "$percent_lines\n$formatted_out"
else
    echo "$formatted_out" | pbcopy
    echo "$formatted_out"
fi
