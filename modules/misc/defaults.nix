{ config, pkgs, ... }: {

  system.activationScripts.postUserActivation.text = ''
    echo "⚙️ Running miscellaneous system tweaks..."
    # Enable Firewall
    sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on
    
    # Time Machine
      #tmutil enable
        # Performs automatic backups to an external drive
        # Internal NAND wear: Zero
        # External drive wear: High
      tmutil enablelocal
        # Performs local APFS backups, not needing an external drive
        # Internal NAND wear: Negligible, only records metadata

    # Set Safari as the default browser
      defaultbrowser safari
  '';
}