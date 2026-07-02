#!/usr/bin/env fish

# Run every subscript in CWD
for file in *.fish; fish $file; end

# Reboot
echo "Please enter your user password to reboot and apply changes"
sudo shutdown -r now
