#!/usr/bin/env fish

# LaunchCtl
launchctl load -w /System/Library/LaunchAgents/com.apple.ReportCrash.plist
launchctl load -w /System/Library/LaunchDaemons/com.apple.ReportCrash.Root.plist