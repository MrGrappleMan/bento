{ config, pkgs, ... }: {

  system.activationScripts.postUserActivation.text = ''
# Power Management
# Intended for balanced system longevity and efficiency, while also allowing maximum safe performance levels.
# User should use Caffeine to keep important processes running when triggered.
# Use TouchID for convenience or disable lock upon screen sleep
# https://ss64.com/mac/pmset.html
# https://www.unix.com/man_page/osx/1/pmset/

# Source-agnostic settings:
    
    # Sleeping phase order:
     # 1. Time from inactivity to sleep Display / Disk
      sudo pmset -a displaysleep 4
      # Turn off display after 4 minutes of inactivity ( Less burn-in, discoloration, power )

      sudo pmset -a disksleep 10
      # Disk sleep:
      # 0: Disks are always on, no sleep.
      # Any +ve integer: Disk auto sleeps, this value is not of concern, only its presence.
      # This does not affect the internal NAND's power management

     # 2. Time from inactivity to main sleep
      sudo pmset -a sleep 5 # Sleep after 5 minutes of inactivity ( main reason )

     # 3. Time from sleep to hibernation(entering standby)
      sudo pmset -a standby 1
      # Allow standby - the action which triggers hibernation, prior to which, sleep is RAM only
      # Works on HB25, HB3, but not HB0. Entering standby stops power nap functionality.

      
     sudo pmset -a hibernatemode 3
     # All power consumption, data integrity, data in RAM security, NAND wear is a concern. This requires careful consideration.
     # Other hidden modes are not recommended.
  
     # Hibernatemode 0: ( HB0: Forced s2idle, masked hibernate.target )
      # RAM only, hibernation triggers are ignored, best with AC
      # Saves NAND writes but uses more power. Not good for BAT/UPS, loss of data may occur.
      # For headless AC, use Wake on LAN (WoL) or some launchd service that wakes the system, if saving energy when your clusters sleep.
  
     # Hibernatemode 3: ( HB3: Like hybrid-sleep.target, graceful )
      # RAM + Disk, minor power consumption, best with BAT/UPS
      # True writes to disk are performed after an optimal period post sleep.
      # Balances power consumption and data safety. Power management is done on a slow-halting spectrum.
  
     # Hibernatemode 25: ( HB25: Traditional hibernation )
      # Disk only, RAM contents are discarded immediately after hibernation.
      # Can be frustrating if you need to wake up quickly from hibernation, else maintains battery well.
      
  sudo pmset -a powermode 0
    # Set to auto for all power sources, intelligent regulation.
    # It prioritizes efficiency, with uncapped safe performance levels.
    # Low power mode sets a hard cap, high performance mode has reduced efficiency.

 sudo pmset -a standby 1
 # Allow standby - the action which triggers hibernation, prior to which, sleep is RAM only
 # Works on HB25, HB3, but not HB0. Entering standby stops power nap functionality.

# Source-specific settings overrides:
 # Where different settings for each source yields better results.

 # Battery Power (BAT -b)
  # HB3 is the better choice here
  sudo pmset -b lessbright 1
    # System reduces some brightness when switching to X power source


 # Uninterruptible Power Supply (UPS -u)
  # Objective: Terminal emergency state. Dump to disk and kill power fast when inactive

 # Charger / Wall Power (AC -c)
  # For charging, HB0 is the default and is perfectly fine, as the battery is a failsafe.
  # For AC, HB3(like wait 18 hours before hibernation) is better as it saves to disk.
  # For most people, this doesn't matter, but there may be accidental power cuts. In that case, you should just save your data.

  '';
}