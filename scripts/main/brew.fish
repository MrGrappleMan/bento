#!/usr/bin/env fish

# Enable Homebrew analytics - https://docs.brew.sh/Analytics
# Saves Time: The team knows exactly which tools to update.
# Stops Errors: They can track which tools fail to install and fix them.
# Keeps it Safe: The data is anonymous. It only tracks the package name and your command.
brew analytics on

# Load declarative packages
## General
brew bundle install --file main

