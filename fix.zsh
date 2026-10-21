#!/usr/bin/env zsh
set -euo pipefail

echo "🔧 Attempting safe system problem fixes"
echo "Expect minor slowdowns due to cache removal"

# 1. Reset ATS font database
sudo atsutil databases -remove

# 2. User and system caches
rm -rf ~/Library/Caches/* 2>/dev/null || true

sudo rm -rf /Library/Caches/* 2>/dev/null || true

# 3. DNS cache
sudo dscacheutil -flushcache
sudo killall -HUP mDNSResponder

# 4. Reset ambient display sensors
sudo pmset resetdisplayambientparams

echo "Wipe.DS_Store files?"
echo -n "Continue? (y/N): "
read -k 1 -t 10 reply
echo ""
if [[ "$reply" == "y" || "$reply" == "Y" ]]; then
  find ~ -name '.DS_Store' -depth -exec rm {} \; 2>/dev/null || true
fi

echo "