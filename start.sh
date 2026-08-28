#!/usr/bin/env zsh
clear

# ------------------------------------------------------------------------------
# ⚙️ Prerequisites:
# 1. MacOS
# 2. arm64
# 3. Standard, non-root user
# ------------------------------------------------------------------------------

# 1. Check if the script is running on macOS
    if [[ "$OSTYPE" != darwin* ]]; then
        echo "Error: This script is for macOS" >&2
        echo "Try our project https://github.com/MrGrappleMan/aldehyde for Linux!"
        exit 1
    fi

# 2. Check if the script is running as a standard user
    if [[ $UID -eq 0 ]]; then
        echo "Error: Do not run this script as root." >&2
        echo "Run it as a standard user instead, as it applies many user-level changes." >&2
        echo "Remove the \"sudo\" prefix and try again." >&2
        exit 1
    fi

# 3. Check if SIP is disabled
    sip_status=$(csrutil status 2>&1)
    if echo "$sip_status" | grep -q "disabled"; then
        echo "Error: System Integrity Protection (SIP) has disabled components."
        echo "To get the original state, follow video or this text if you continue getting this error."
        echo
        echo "Video guide: https://www.youtube.com/watch?v=Fx_1OPFzu88&t=29s"
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

# ------------------------------------------------------------------------------
# Get required software:
# Lix
# Homebrew
# ------------------------------------------------------------------------------

# Lix
    curl --proto '=https' --tlsv1.2 -sSf -L https://install.lix.systems/lix | sh -s -- install --no-confir
    source ~/.zshrc

# Brew
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    source ~/.zshrc
    # Git
        brew install git
        source ~/.zshrc

# ------------------------------------------------------------------------------
# Apply and reboot
# ------------------------------------------------------------------------------

# Apply configuration
darwin-rebuild switch \
    --flake "$repo_dir#main" \
    --option extra-experimental-features "nix-command flakes" \
    --no-write-lock-file \
    --refresh

# Reboot
echo "Rebooting"
sudo shutdown -r now
