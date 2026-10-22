#!/usr/bin/env zsh
set -euo pipefail

# Basic fixes attempts
    echo "🔧 Attempting safe system problem fixes"
    echo "Expect minor slowdowns due to cache removal"
    # Reset ATS font database
        sudo atsutil databases -remove
    # User and system caches
        rm -rf ~/Library/Caches/*
        sudo rm -rf /Library/Caches/*
    # DNS cache
        sudo dscacheutil -flushcache
        sudo killall -HUP mDNSResponder
    # Reset ambient display sensors
        sudo pmset resetdisplayambientparams
# Risky fix methods
    echo "🔧 Attempting risky problem fixes"
    # .DS_Store wipe
        echo "Wipe .DS_Store files?"
        echo "Any custom folder arrangements, sorted views, or specific icon placements that"
        echo "you have manually arranged in Finder will be reset to default to fix issues"
        echo -n "Continue? : "
        if [[ "$reply" == "y" || "$reply" == "Y" ]]; then
            find ~ -name '.DS_Store' -depth -exec rm {} \;
        fi
# Reboot
    echo "It is recommended to reboot as soon as possible"
echo "avoid doing any important work till you reboot"
