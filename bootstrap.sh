#! /bin/sh

# Install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"

# Clone git
git clone https://github.com/AnH0ang/dotfiles.git "${HOME}"/.config

# Run configure script
sh "${HOME}"/.config/setup.sh

# Set remote to ssh
git -C "${HOME}/.config" remote set-url origin git@github.com:AnH0ang/dotfiles.git
