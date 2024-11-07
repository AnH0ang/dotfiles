#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Ruff Format
# @raycast.mode fullOutput

# Optional parameters:
# @raycast.icon 👔
# @raycast.packageName Writing

pbpaste | ~/.local/bin/ruff format - | tee | pbcopy
