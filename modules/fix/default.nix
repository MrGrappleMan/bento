
# Fixes issues without overriding manually set data
# Mainly caches and logs

sudo atsutil databases -remove
# Remove text database caches

sudo rm -rf ~/Library/Caches/*
# User cache directories

sudo rm -rf /Library/Caches/*
# System cache directories

sudo dscacheutil -flushcache
# Flush DNS cache

sudo pmset resetdisplayambientparams
# Recalibrate ambient display management learned data, good if changing workspaces to radically different lighting conditions.
# No needed to be done every time you visit a different workspace




# Fixes issues, but also overrides your manually set data

# Delete all .DS_Store files on user home, custom appended info for files will get wiped
find ~ -name '.DS_Store' -depth -exec rm {} \;
