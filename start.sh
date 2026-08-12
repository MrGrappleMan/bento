#!/usr/bin/env bash
#
# ------------------------------------------------------------------------------
# ⚙️ Step 1: OS Verification & System Checks
# ------------------------------------------------------------------------------
sys_name=$(uname -s)
ostype=""

case "$sys_name" in
    Darwin)
        # 🔍 Nix presence check
        if ! command -v nix >/dev/null 2>&1; then
            echo "❌ Error: Nix is not installed or not in PATH."
            exit 1
        fi

        # 🔍 SIP status check
        if command -v csrutil >/dev/null 2>&1; then
            sip_status=$(csrutil status)
            echo "ℹ️ macOS SIP Status: $sip_status"
        else
            echo "⚠️ Warning: Unable to verify SIP status via csrutil."
        fi

        ostype="dw"
        ;;

    Linux)
        # 🔍 Verify system is NixOS
        if [ ! -e /etc/NIXOS ]; then
            echo "❌ Error: Host operating system is not NixOS (/etc/NIXOS missing)."
            exit 1
        fi

        # 🔍 Nix presence check
        if ! command -v nix >/dev/null 2>&1; then
            echo "❌ Error: Nix is not installed or not in PATH."
            exit 1
        fi

        ostype="nx"
        ;;

    *)
        echo "❌ Error: Unsupported operating system ($sys_name)."
        exit 1
        ;;
esac

echo "✅ OS Check Passed: ostype = $ostype"

# ------------------------------------------------------------------------------
# 🎯 Step 2: Target Environment Selection
# ------------------------------------------------------------------------------
echo ""
echo "Select Target Environment Type:"
echo "  • dsk : Desktop / Workstation (Default)"
echo "  • srv : Headless Server Engine"

# Handle interactive prompting when piped directly (e.g. curl | bash)
if [ -t 0 ]; then
    read -p "Target environment type? [dsk/srv] (default: dsk): " env_input
else
    if [ -c /dev/tty ]; then
        read -p "Target environment type? [dsk/srv] (default: dsk): " env_input < /dev/tty
    else
        env_input="dsk"
    fi
fi

usecase=""
case "$env_input" in
    srv|server|2)
        usecase="srv"
        ;;
    *)
        usecase="dsk"
        ;;
esac

echo "✅ Target Environment Selected: $usecase"

# ------------------------------------------------------------------------------
# 🧬 Step 3: Automatic Architecture Derivation
# ------------------------------------------------------------------------------
raw_arch=$(uname -m)
arch=""

case "$raw_arch" in
    x86_64)
        arch="x86"
        ;;
    arm64|aarch64)
        arch="arm"
        ;;
    *)
        echo "❌ Error: Unsupported architecture ($raw_arch). Must be x86_64 or arm64/aarch64."
        exit 1
        ;;
esac

echo "✅ Architecture Derived: $arch (from $raw_arch)"

# ------------------------------------------------------------------------------
# 📦 Step 3.5: Repository Management & Hardware Configuration
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
# 🚀 Step 4: Dynamic Rebuild Phase
# ------------------------------------------------------------------------------
target_attribute="$ostype-$usecase-$arch"

echo ""
echo "🚀 Deploying target attribute: $repo_dir#$target_attribute"
echo "------------------------------------------------------------------------------"

# Require rebooting on NixOS
if [ "$ostype" = "nx" ]; then
    sudo nixos-rebuild boot \
        --flake "$repo_dir#$target_attribute" \
        --extra-experimental-features "nix-command flakes" \
        --no-write-lock-file \
        --refresh
else
    if [ "$ostype" = "dw" ]; then
        darwin-rebuild switch \
            --flake "$repo_dir#$target_attribute" \
            --extra-experimental-features "nix-command flakes" \
            --no-write-lock-file \
            --refresh
    fi
fi
