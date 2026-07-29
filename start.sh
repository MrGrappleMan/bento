#!/usr/bin/env zsh

# Check and terminate if root
if [ "$EUID" -eq 0 ]; then
    echo "Do not run as root"
    read -r -p "Press any key to quit..." -n1 -s
    exit 1
fi

# Check SIP status and terminate if disabled
if csrutil status | string match -q "*disabled*"
    echo "SIP is disabled. Please enable it via 'csrutil enable' in Recovery Mode."
    read -r -p "Press any key to quit..." -n1 -s
    exit 1
end

# Go to home directory
cd

# Install Homebrew in non-interactive mode
NONINTERACTIVE=1 bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Refresh shell to be able to recognize homebrew
source ~/.zshrc

# Install Fish shell and Git
brew install fish git

# Remove existing repo files, if any
rm -rf /tmp/bento

# Get the repo
git clone https://github.com/MrGrappleMan/bento.git /tmp/bento

# Enter repo
cd /tmp/bento

# Install Lix
curl --proto '=https' --tlsv1.2 -sSf -L https://install.lix.systems/lix | sh -s -- install

# Install Nix-Darwin
sudo nix run nix-darwin/master#darwin-rebuild -- switch

# Install the repo flake
nix run nix-darwin -- switch --flake github:MrGrappleMan/your-repo#your-hostname
