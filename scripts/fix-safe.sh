
# Text database caches
sudo atsutil databases -remove # Remove text database caches
sudo atsutil server -shutdown # Stop text cache server
sudo atsutil server -ping # Start text cache server

# System directories
sudo rm -rf ~/Library/Caches/* # User cache directories
sudo rm -rf /Library/Caches/* # System cache directories

# Networking
sudo dscacheutil -flushcache # Flush DNS cache
