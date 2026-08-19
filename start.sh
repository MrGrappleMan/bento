#!/usr/bin/env bash
#
# ------------------------------------------------------------------------------
# ⚙️ Step 1: OS Verification & System Checks
# ------------------------------------------------------------------------------
sys_name=$(uname -s)
ostype=""

if [[ $EUID -eq 0 ]]; then
    echo "This script should not be executed as root! Exiting..."
    exit 1
fi

case "$sys_name" in
    Darwin)
        # Lix/Nix
            echo "Installing Lix"
            curl --proto '=https' --tlsv1.2 -sSf -L https://install.lix.systems/lix | sh -s -- install --no-confirm
            echo "Refreshing bash"
            source ~/.bashrc

        # Brew
            echo "Installing Brew"
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
            echo "Refreshing bash"
            source ~/.bashrc
            # Get git from Homebrew
                echo "Installing Git"
                brew install git
                echo "Refreshing bash"
                source ~/.bashrc

        # SIP status check
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

        ostype="dw"
        ;;

    Linux)
        # Is official NixOS?
        if [[ ! "$(grep -i nixos </etc/os-release)" ]]; then
          echo "This only works on proper NixOS! Get it from https://nixos.org/download/"
          echo "You can run this in either the installed environment or a live booted image(intended for first-time setup only)."
          exit 1
        fi

        ostype="nx"
        ;;

    *)
        echo "($sys_name) is unsupported"
        exit 1
        ;;
esac

# ------------------------------------------------------------------------------
# 🧬 Step 2: Automatic Architecture Derivation
# ------------------------------------------------------------------------------
raw_arch=$(uname -m)
arch=""

case "$raw_arch" in
    x86_64)
        arch="x86"
        ;;
    arm64)
        arch="arm"
        ;;
    *)
        echo "Only x86_64 or arm64 is supported"
        exit 1
        ;;
esac

# ------------------------------------------------------------------------------
# 📦 Step 3: Repository Management & Hardware Configuration
# ------------------------------------------------------------------------------
# Helper function to run git, using nix-shell fallback if git is not installed
git_cmd() {
    if command -v git >/dev/null 2>&1; then
        git "$@"
    elif command -v nix-shell >/dev/null 2>&1; then
        # Safely escape and reconstruct the arguments for nix-shell --run
        local args=""
        local arg
        for arg in "$@"; do
            local escaped
            escaped=$(printf '%s' "$arg" | sed "s/'/'\\\\''/g")
            args="$args '$escaped'"
        done
        nix-shell -p git --run "git $args"
    else
        echo "❌ Error: git is not installed and nix-shell is not available."
        exit 1
    fi
}

repo_dir=""
# Detect if we are already running inside a local clone of bento
if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    git_url=$(git remote get-url origin 2>/dev/null)
    if echo "$git_url" | grep -q "bento"; then
        repo_dir=$(git rev-parse --show-toplevel 2>/dev/null)
        echo "ℹ️ Running from local clone: $repo_dir"
    fi
fi

if [ -z "$repo_dir" ]; then
    repo_dir="$HOME/.config/bento"
    echo "ℹ️ Bento repository will be managed in $repo_dir"
    if [ -d "$repo_dir" ]; then
        echo "🔄 Updating existing Bento repository in $repo_dir..."
        (cd "$repo_dir" && git_cmd pull) || echo "⚠️ Warning: git pull failed. Proceeding with existing local copy."
    else
        echo "📥 Cloning Bento repository to $repo_dir..."
        mkdir -p "$(dirname "$repo_dir")"
        git_cmd clone https://github.com/MrGrappleMan/bento.git "$repo_dir"
    fi
fi

if [ "$ostype" = "nx" ]; then
    echo "⚙️ Copying hardware configuration from /etc/nixos/hardware-configuration.nix..."
    if [ -f /etc/nixos/hardware-configuration.nix ]; then
        cp /etc/nixos/hardware-configuration.nix "$repo_dir/linux/hardware-configuration.nix"
        echo "✅ Copy successful."
    else
        echo "⚠️ Warning: /etc/nixos/hardware-configuration.nix not found."
        echo "⚙️ Generating new hardware configuration..."
        sudo nixos-generate-config --show-hardware-config > "$repo_dir/linux/hardware-configuration.nix"
        echo "✅ Generation successful."
    fi
    # Ensure the hardware configuration is tracked by git, otherwise nix flakes ignores it
    (cd "$repo_dir" && git_cmd add linux/hardware-configuration.nix)
fi

# ------------------------------------------------------------------------------
# 🚀 Step 4: Build and Reboot
# ------------------------------------------------------------------------------
target_attribute="$ostype-$arch"

# Require rebooting on NixOS
if [ "$ostype" = "nx" ]; then
    sudo nixos-rebuild boot \
        --flake "$repo_dir#$target_attribute" \
        --option extra-experimental-features "nix-command flakes" \
        --no-write-lock-file \
        --refresh
    systemctl reboot
else
    if [ "$ostype" = "dw" ]; then
        darwin-rebuild switch \
            --flake "$repo_dir#$target_attribute" \
            --option extra-experimental-features "nix-command flakes" \
            --no-write-lock-file \
            --refresh
    fi
    sudo shutdown -r now
fi
