#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Format SQL in Clipboard
# @raycast.mode fullOutput

# Optional parameters:
# @raycast.icon 👔
# @raycast.packageName Writing

# Extract the text from the clipboard, remove any leading '%' characters, and format the text
formatted_out=$(pbpaste | ~/.local/bin/sqlfluff format --dialect hive --config ~/.config/sqlfluff/.sqlfluff -)

echo -e "Formatted text copied to clipboard:"
echo -e "-----------------------------------\n"

# Output the formatted text
echo "$formatted_out" | pbcopy
echo "$formatted_out"
