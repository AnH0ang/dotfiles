#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Unformat Clipboard Content
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 👕
# @raycast.packageName Unformat Clipboard Content

pbpaste | pbcopy
echo "Unformatting successful"
