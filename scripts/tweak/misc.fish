#!/usr/bin/env fish

# LaunchCtl
launchctl load -w /System/Library/LaunchAgents/com.apple.ReportCrash.plist
launchctl load -w /System/Library/LaunchDaemons/com.apple.ReportCrash.Root.plist

# Enable Homebrew analytics - https://docs.brew.sh/Analytics
# Saves Time: The team knows exactly which tools to update.
# Stops Errors: They can track which tools fail to install and fix them.
# Keeps it Safe: The data is anonymous. It only tracks the package name and your command.
brew analytics on

# Enable Firewall
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on

# Time Machine
# tmutil enable
  # Performs automatic backups to an external drive
  # Internal NAND wear: Zero
  # External drive wear: High
tmutil enablelocal
 # Performs local APFS backups, not needing an external drive
  # Internal NAND wear: Negligible, only records metadata

