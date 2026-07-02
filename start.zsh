#!/usr/bin/env zsh

# Go to home directory
cd

# Install Homebrew
bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Refresh shell
source ~/.zshrc

# Install Fish shell and Git
brew install fish git

# Remove existing repo files
rm -rf /tmp/bento

# Get the repo
git clone https://github.com/MrGrappleMan/bento.git

# Enter repo
cd /tmp/bento

# Run main script
fish main.fish
