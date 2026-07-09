#!/usr/bin/env fish

# Run every tweak script
for file in scripts/tweaks/*.fish; fish $file; end

# Prompt if fixes are needed, and run appropriate script



# Reboot
echo "Please enter your user password to reboot and apply changes"
sudo shutdown -r now
