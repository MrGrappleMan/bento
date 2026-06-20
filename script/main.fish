#!/usr/bin/env fish

## Add Homebrew to PATH
fish_add_path "/opt/homebrew/bin/"

## Variables
dfwrt="defaults write"

# Integrity measures, prevents corruption and data loss
dfwrt com.apple.frameworks.diskimages skip-verify -bool false
dfwrt com.apple.frameworks.diskimages skip-verify-locked -bool false
dfwrt com.apple.frameworks.diskimages skip-verify-remote -bool false
tmutil enable # Allow system rollbacks
dfwrt com.apple.Finder WarnOnEmptyTrash -bool true # Warn user when emptying trash, to be careful

# Font Smoothing and antialiasing
dfwrt -g CGFontRenderingFontSmoothingDisabled -bool NO
defaults -currentHost write -globalDomain AppleFontSmoothing -int 3

# Productivity
sudo dfwrt /Library/Preferences/com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true # Add them if you want to manually
dfwrt com.apple.finder "FXEnableExtensionChangeWarning" -bool "false" # Not permanently destructive, no warning required here
dfwrt com.apple.TextEdit RichText -int 0 # Just use Notion or Obsidian instead of this
dfwrt -g NSAutomaticSpellingCorrectionEnabled -bool false
dfwrt NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
dfwrt NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true
dfwrt com.apple.Safari HomePage -string "https://scidsg.github.io/relaylove/"
dfwrt com.apple.Finder ShowHardDrivesOnDesktop -bool true
dfwrt com.apple.Finder ShowExternalHardDrivesOnDesktop -bool true
dfwrt com.apple.Finder ShowRemovableMediaOnDesktop -bool true
dfwrt com.apple.Finder ShowMountedServersOnDesktop -bool true
dfwrt com.apple.finder "FXEnableExtensionChangeWarning" -bool false
dfwrt /Library/Preferences/com.apple.mDNSResponder.plist NoMulticastAdvertisements -bool NO
dfwrt com.apple.finder FXDefaultSearchScope -string "SCcf"

# Enable Telemetry
launchctl load -w /System/Library/LaunchAgents/com.apple.ReportCrash.plist
sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.ReportCrash.Root.plist
brew analytics on
dfwrt com.apple.appleseed.FeedbackAssistant Autogather -bool true

# Security
dfwrt com.apple.LaunchServices LSQuarantine -bool true
dfwrt com.apple.Safari WarnAboutFraudulentWebsites -bool true

# Ecosystem
dfwrt com.apple.desktopservices DSDontWriteNetworkStores -bool false
dfwrt com.apple.desktopservices DSDontWriteUSBStores -bool false

# Energy
pmset -b sleep 2

# ON HiDPI, better external screen resolution
sudo dfwrt /Library/Preferences/com.apple.windowserver.plist DisplayResolutionEnabled -bool true

# Bluetooth codecs
dfwrt bluetoothaudiod "Enable AptX codec" -bool true
dfwrt bluetoothaudiod "Enable AAC codec" -bool true

# x86_64 support
softwareupdate --install-rosetta --agree-to-license
