{ config, pkgs, ... }: {

  system.activationScripts.postUserActivation.text = ''
    # Balanced system longevity, efficiency, yet allow access to maximum safe performance levels.
    # You must balance power consumption, data integrity, security, NAND wear appropriately as per the situation.
    # Use Caffeine on macbooks to keep the system running for tasks like compiling, rendering, or running simulations.
    # Use TouchID for convenience or disable lock upon screen sleep
    # Sources: 
      # https://ss64.com/mac/pmset.html
      # https://www.unix.com/man_page/osx/1/pmset/
      # https://www.dssw.co.uk/reference/pmset/

    # displaysleep ( No HID input > Display sleep )
      # Display sleep timer in minutes.
      # Set to a low value to avoid display burn-in, discoloration, and reduce power consumption.
      # 0: Display never turns off after idling
      # X: Display turns off after X minutes of inactivity (should be ideally less than Y / sleep timer)

    # sleep ( No HID input or process wakelock > System sleep )
      # Sleep timer in minutes, can halt important background tasks, recommended for battery life
      # 0: System never sleeps
      # Y: System sleeps after Y minutes of inactivity

    # disksleep ( No I/O activity to target HDD > Disk sleeps )
      # Sleep timer for external HDDs
      # 0: Motor never stops, but high disk lifes,
      # +ve integers: Make disk sleep after X minutes of inactivity. Some believe that the value does not matter, as the hardware decides when to make the disk sleep.
      # No impact on SSDs. And internal NAND chip is firmware managed.

    # hibernatemode
      # 0: ( HB0: Forced s2idle, masked hibernate.target )
        # RAM only, hibernation triggers do not do anything.
        # Less SSD writes. But uses more power, so not good for battery based sources ( -b and -u ).
      # 3: ( HB3: Like hybrid-sleep.target, graceful )
        # RAM + Disk, minor power consumption, best with BAT/UPS
        # Writes to disk are performed after pure RAM sleep.
        # Balances power consumption and data safety. Power management is done on a slow-halting spectrum.
      # 25: ( HB25: Traditional hibernation )
        # Disk only, RAM contents are discarded immediately after hibernation.
        # Can be frustrating if you need to wake up quickly from hibernation, else maintains battery well.

    # Source-agnostic settings:
      sudo pmset -a displaysleep 4

    sudo pmset -a powermode 0
    # Set to auto for all power sources, intelligent regulation.
    # It prioritizes efficiency, with uncapped safe performance levels.

    sudo pmset -a standby 1
    # ... > Sleep > [ Standby, proceed to trigger hibernation if 1 ] > Write to disk > ...
    # Works on HB25/HB3, not HB0. Entering standby stops power nap functionality.

    # Source-specific settings:
    # Where different settings for each source yields better results.

    # Battery Power (BAT -b)
    # HB3 is a good balance here
    pmset -b hibernatemode 3

    # Backup power UPSes (UPS -u)
    # The system is at a critical situation, hibernate to disk fast.

    # Charger / Wall Power (AC -c)
    # Optimized for reduced disk writes, background process activity persistence and clusters
    # Portable power banks may get detected as this mode and waste battery life, though inbuilt batteries are designed to last.
    # Sleep manually on power banks as a workaround for now, and unplug once fully charged. Replug at around 50%.
    pmset -c hibernatemode 0 # Never hibernate writes to disk.
    pmset -c sleep 0 # Let background tasks run (eg. BOINC). Can set to +ve, but be sure to have a way to wake headless systems.
    pmset -c standby 0 # Never trigger the hibernation action if accidentally in sleep (partially redundant with hibernatemode 0)
    pmset -c autopoweroff 0 # Extra EU compliance measure to be disabled.
    pmset -c womp 1 # Wake on LAN (WOL) support if accidentally sleeping.
    pmset -c disksleep 60 # Low mechanical stress, longer HDD lifespan.
    pmset -c autorestart 1 # Automatically start the system again after a crash or power failure.
  '';
}