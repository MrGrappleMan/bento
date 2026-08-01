#!/usr/bin/env zsh
# set -e # Exit immediately if a command exits with a non-zero status
clear

# Fail if not MacOS
if [[ $(uname) != "Darwin" ]]; then
    echo "Environment is not macOS, try re-sshing into your macOS machine."
    exit 1
fi

# Fail if root
if [ "$EUID" -eq 0 ]; then
    clear
    echo "Do not run this script directly as root or via sudo."
    echo "There are some user-specific settings that need to be applied as a regular user."
    read -r -p "Press any key to quit..." -n1 -s
    exit 1
fi

# Fail if SIP is disabled
if csrutil status | grep -q "disabled"; then
    clear
    echo "Error: System Integrity Protection (SIP) is disabled."
    echo "To enable SIP, follow the automatically opened video guide or the text below."
    echo
    echo "How to enable SIP:"
    echo
    echo "Enter Recovery Mode: Shut down your Mac, then press and hold the power button until the text, \"Loading startup options\" appears."
    echo "Access Terminal: Select Options > Continue, log in, and then navigate to Utilities > Terminal."
    echo "Reset CSRutil: Type \"sudo csrutil reset\", press Return, type Y to confirm, and enter your administrator password."
    echo "Restart: Once the process completes, restart the machine for the changes to take effect."
    echo "Verification: Log back in and run \"csrutil status\" in Terminal again to ensure SIP is enabled."
    echo
    open https://www.youtube.com/watch?v=Fx_1OPFzu88&t=29s
    read -r -p "Press any key to quit..." -n1 -s
    exit 1
fi

echo "Please quit all applications and save your work before continuing."
echo "Your device will automatically reboot."
echo -n "Continue? (y/N): "
read -k 1 -t 5 reply
echo ""
if [[ "$reply" == "y" || "$reply" == "Y" ]]; then
    echo "Starting..."
else
    echo "Exiting."
    exit 0
fi

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
