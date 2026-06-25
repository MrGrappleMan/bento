#!/usr/bin/env zsh

# Go to home directory
cd /tmp/

# Remove existing repo files
rm -rf /tmp/bento

# Install Homebrew
bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Refresh shell
source ~/.zshrc

# Install Fish shell and Git
brew install fish git

# Clone the repository
git clone https://github.com/MrGrappleMan/bento.git
cd bento

