#!/usr/bin/env zsh
# set -e # Exit immediately if a command exits with a non-zero status
clear



cd "$HOME"

# Install Homebrew if not found (Non-Interactive)
if ! command -v brew >/dev/null 2>&1; then
    echo "🍺 Installing Homebrew..."
    NONINTERACTIVE=1 bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Load Homebrew into zsh
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Install Lix
if ! command -v nix >/dev/null 2>&1; then
    echo "❄️ Installing Lix package manager..."
    curl --proto '=https' --tlsv1.2 -sSf -L https://install.lix.systems/lix | sh -s -- install --no-confirm

    # Source Nix/Lix daemon into the current running script context
    if [ -f "/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh" ]; then
        . "/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh"
    fi
fi

# Apply flake from repo directly, use up to date files
echo "🚀 Applying the configuration..."
nix run nix-darwin -- switch --flake github:MrGrappleMan/bento#defaulthost --extra-experimental-features "nix-command flakes" --no-write-lock-file --refresh

# Reboot
sudo shutdown -r now
