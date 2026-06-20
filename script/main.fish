#!/usr/bin/env fish

# 
fish_add_path "/opt/homebrew/bin/"

# TMUtil
tmutil enable # Enable time machine

# LaunchCtl
launchctl load -w /System/Library/LaunchAgents/com.apple.ReportCrash.plist
launchctl load -w /System/Library/LaunchDaemons/com.apple.ReportCrash.Root.plist

# Brew
brew analytics on

# Energy
pmset -b sleep 2
