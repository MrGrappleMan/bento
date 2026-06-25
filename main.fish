#!/usr/bin/env fish

# Homebrew
fish_add_path "/opt/homebrew/bin/"
brew analytics on

# SIP (System Integrity Protection) check, warn user
CHKCSR=$(csrutil status)
if echo "$CHKCSR" | grep -q "disabled"; then
    WARNCSR=1
else
    WARNCSR=0
fi

# Defaults
cd /tmp/bento/export/plist/
defaults import com.apple.dock com.apple.dock.plist
defaults import com.apple.finder com.apple.finder.plist
defaults import com.apple.Safari com.apple.Safari.plist

# LaunchCtl
launchctl load -w /System/Library/LaunchAgents/com.apple.ReportCrash.plist
launchctl load -w /System/Library/LaunchDaemons/com.apple.ReportCrash.Root.plist

# Power Management
#
# Standby
# As a related concept, standby is a state that occurs after hibernation is triggered, clearing out RAM and preserving disk contents, and killing Power Nap.
# Standby is intended to work best on mode 3. On mode 0, hibernation is not even triggered. On mode 25, the machine is in a 'standby' like state just after hibernation.
# Standby closely replicates mode 25 on mode 3, but allows a minor grace period before true power-off is initiated.
# 
# Hibernation:
# All power consumption, data safety and NAND wear is a concern. This topic is highly complex and requires careful consideration.
# Hibernatemode 0: ( Like s3 with s2idle wakeup speeds )
# Disable hibernation completely, not recommended for user facing environments
# RAM only, continues sleep state even when hibernation(thus no standby) is triggered. 
# For headless environments, it is best to have power nap(in sleep), or WoL or some launchd service that wakes the system up, if you intend to let your clusters sleep.
# Hibernatemode 3: ( Like hybrid-sleep.target, most modern and graceful mode ) 
# RAM + Disk, contents are preserved on wakeup, minor power consumption is expected for a short time.
# Eventually after some time, it enters standby mode.
# Hibernatemode 25: ( Simple hibernation )
# Disk only, for maximum battery life, best when the user has been inactive for a long time.
# This mode makes Power Nap effectively useless after hibernation is triggered, which ideally should be the case.
# Why keep the RAM contents stranded after hibernation? A 30 second delay post-hibernation wake is worth a few more minutes of true battery life.

# Timeouts:
# User is heavily recommended to install Caffeine, for uninterrupted activity without continous user interaction being a requirement(compilation, rendering, inference)
# Use TouchID for convenience or disable lock upon screen sleep
sudo pmset -a sleep 5 # Sleep after 5 minutes of inactivity (reduce main reason for power consumption)
sudo pmset -a displaysleep 4 # Turn off display after 4 minutes of inactivity (Reduce burn-in risk, discoloration and power consumption)
sudo pmset -a disksleep 5 # 0 = always on, other positive values = macos does sleeping timeout automatically, value not obeyed. Mainly for external HDDs.
sudo pmset -a lessbright 1 # Lets the system auto adjust brightness based on ambient light, power and other factors
#sudo pmset -a halfdim 1 # Legacy option, may be ignored by modern macos versions

# Master Control:
sudo pmset -a powermode 0 # Set to automatic for all power sources, intelligent regulation

# ==============================================================================
# Battery Power (BAT): RAM-Only Sleep, Ultra-Delayed Hibernation
# ==============================================================================
# For battery, we want the system to always keep contents in RAM, and consider hibernating only after battery is like < 10%
# > (system should wake itself at suitable intervals for battery monitoring and initiating hibernation)
# - highstandbythreshold 10: Divides battery capacity into "high" (>10%) and "low" (<10%) states.
# - standbydelayhigh 86400: If battery is > 10%, hibernate after 1 day of sleep.
# - standbydelaylow 300: If battery is < 10%, hibernate after 5 minutes of sleep.
#sudo pmset -b highstandbythreshold 10
#sudo pmset -b standbydelayhigh 86400
#sudo pmset -b standbydelaylow 300

# ==============================================================================
# Uninterruptible Power Supply (UPS): High-Efficiency Safe State
# ==============================================================================
# - Treat as reliable but prioritize fast transition to disk to protect against long outages.
#sudo pmset -u standbydelayhigh 600 # Hibernate after 10 minutes on UPS sleep

# ==============================================================================
# Charger / Wall Power (AC): Prevent Unexpected Interruption/Accidental Disconnects
# ==============================================================================
# For AC power, we want the system to hibernate, power supply may be unstable or the power cable may be unplugged accidentally.
# - standbydelayhigh 1200: Move to a deep, safe state after 20 minutes of inactivity.
#sudo pmset -c standbydelayhigh 1200
#sudo pmset -c ttyskeepawake 1 # Don't sleep if remote tasks or scripts are running, manually triggering Caffeine is better
#sudo pmset -c womp 1           # Wake on Magic Packet (useful for remote workflows)
