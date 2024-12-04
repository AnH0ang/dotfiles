#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Format SQL in Clipboard
# @raycast.mode fullOutput

# Optional parameters:
# @raycast.icon 👔
# @raycast.packageName Format SQL
# @raycast.argument1 { "type": "dropdown", "placeholder": "hive", "data": [{"title": "hive", "value": "hive"}, {"title": "BigQuery", "value": "bigquery"}] }

# Check if sqlfluff is installed
if ! command -v ~/.local/bin/sqlfluff &>/dev/null; then
    echo "Error: sqlfluff is not installed"
    echo "Please install it using: uv tool install sqlfluff"
    exit 1
fi

# Extract the text from the clipboard, remove any leading '%' characters, and format the text
formatted_out=$(pbpaste | ~/.local/bin/sqlfluff format --dialect "$1" --config ~/.config/sqlfluff/.sqlfluff -)

# Output the formatted text
echo "$formatted_out" | pbcopy
echo "$formatted_out"
