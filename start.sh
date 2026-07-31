#!/usr/bin/env zsh

set -e # Exit immediately if a command exits with a non-zero status

clear

# 1. Check and terminate if root
if [ "$EUID" -eq 0 ]; then
    clear
    echo "Do not run this script directly as root or via sudo."
    echo "There are some user-specific settings that need to be applied as a regular user."
    read -r -p "Press any key to quit..." -n1 -s
    exit 1
fi

# 2. Check SIP status using native Zsh syntax
if csrutil status | grep -q "disabled"; then
    clear
    echo "Error: System Integrity Protection (SIP) is disabled."
    echo "To enable SIP, follow the automatically opened video guide or the text below."
    echo
    echo "How to enable SIP:"
    echo
    echo "Enter Recovery Mode: Shut down your Mac, then press and hold the power button until the text, \"Loading startup options\" appears."
    echo "Access Terminal: Select Options > Continue, log in, and then navigate to Utilities > Terminal."
    echo "Reset CSRutil: Type sudo csrutil reset, press Return, type Y to confirm, and enter your administrator password."
    echo "Restart: Once the process completes, restart the machine for the changes to take effect."
    echo "Verification: Log back in and run csrutil status in Terminal again to ensure SIP is enabled."
    open https://www.youtube.com/watch?v=Fx_1OPFzu88&t=29s
    read -r -p "Press any key to quit..." -n1 -s
    exit 1
fi

cd "$HOME"

# 3. Install Homebrew (Non-Interactive)
if ! command -v brew >/dev/null 2>&1; then
    echo "🍺 Installing Homebrew..."
    NONINTERACTIVE=1 bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Load Homebrew into current shell environment
    if [ -f "/opt/homebrew/bin/brew" ]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
fi

# 4. Install Git & Fish
echo "📦 Installing Git and Fish via Brew..."
brew install git fish

# 5. Install Lix
if ! command -v nix >/dev/null 2>&1; then
    echo "❄️ Installing Lix package manager..."
    curl --proto '=https' --tlsv1.2 -sSf -L https://install.lix.systems/lix | sh -s -- install --no-confirm

    # Source Nix/Lix daemon into the current running script context
    if [ -f "/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh" ]; then
        . "/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh"
    fi
fi

# 6. Apply flake remotely
echo "🚀 Applying Bento nix-darwin configuration..."
nix run nix-darwin -- switch --flake github:MrGrappleMan/bento#defaulthost --extra-experimental-features "nix-command flakes" --no-write-lock-file --refresh

# 7. Reboot
sudo shutdown -r now