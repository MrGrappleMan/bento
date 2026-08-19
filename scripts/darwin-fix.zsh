#!/usr/bin/env zsh
set -euo pipefail

echo "🧹 Running safe system cache and state cleanup..."

# 1. Reset ATS (Apple Type Services) font database
sudo atsutil databases -remove

# 2. Clear user and system caches (skipping directory itself to avoid permission breaks)
echo "  -> Clearing User Caches..."
rm -rf ~/Library/Caches/* 2>/dev/null || true

echo "  -> Clearing System Caches..."
sudo rm -rf /Library/Caches/* 2>/dev/null || true

# 3. Flush DNS cache
echo "  -> Flushing DNS Cache..."
sudo dscacheutil -flushcache
sudo killall -HUP mDNSResponder

# 4. Recalibrate ambient display sensors
echo "  -> Resetting Ambient Display Parameters..."
sudo pmset resetdisplayambientparams

echo "✅ Safe system maintenance complete!"
echo

echo "  -> Wipe .DS_Store files..."
echo "⚠️  WARNING: This will wipe custom folder view metadata (.DS_Store files) across your entire Home directory."
echo "Please quit all applications and save your work before running this script."
echo -n "Continue? (y/N): "
read -k 1 -t 10 reply
echo ""
if [[ "$reply" == "y" || "$reply" == "Y" ]]; then
  find ~ -name '.DS_Store' -depth -exec rm {} \; 2>/dev/null || true
  echo "✅ Wiped .DS_Store metadata!"
else
  echo "🛑 Cancelled or timeout reached"
fi

exit 0