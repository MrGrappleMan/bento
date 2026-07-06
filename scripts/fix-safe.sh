
# This script fixes potential issues with you Mac without, changes that you have made, being disrupted
# Mainly caches and logs

# Main removals

sudo atsutil databases -remove # Remove text database caches

sudo rm -rf ~/Library/Caches/* # User cache directories
sudo rm -rf /Library/Caches/* # System cache directories

sudo dscacheutil -flushcache # Flush DNS cache

sudo pmset resetdisplayambientparams # Recalibrate ambient display management learned data, good if changing workspaces to radically different lighting conditions.

# Apply changes
sudo atsutil server -shutdown # Stop text cache server
sudo atsutil server -ping # Start text cache server
sudo killall Dock