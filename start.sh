#!/usr/bin/env fish
#
# ------------------------------------------------------------------------------
# ⚙️ Step 1: OS Verification & System Checks
# ------------------------------------------------------------------------------
set -l sys_name (uname -s)
set -l ostype ""

switch $sys_name
    case Darwin
        # 🔍 Nix presence check
        if not command -v nix >/dev/null 2>&1
            echo "❌ Error: Nix is not installed or not in PATH."
            exit 1
        end

        # 🔍 SIP status check
        if command -v csrutil >/dev/null 2>&1
            set -l sip_status (csrutil status)
            echo "ℹ️ macOS SIP Status: $sip_status"
        else
            echo "⚠️ Warning: Unable to verify SIP status via csrutil." [⚠️toVerify]
        end

        set ostype "dw"

    case Linux
        # 🔍 Verify system is NixOS
        if not test -e /etc/NIXOS
            echo "❌ Error: Host operating system is not NixOS (/etc/NIXOS missing)."
            exit 1
        end

        # 🔍 Nix presence check
        if not command -v nix >/dev/null 2>&1
            echo "❌ Error: Nix is not installed or not in PATH."
            exit 1
        end

        set ostype "nx"

    case '*'
        echo "❌ Error: Unsupported operating system ($sys_name)."
        exit 1
end

echo "✅ OS Check Passed: ostype = $ostype"

# ------------------------------------------------------------------------------
# 🎯 Step 2: Target Environment Selection
# ------------------------------------------------------------------------------
echo ""
echo "Select Target Environment Type:"
echo "  • dsk : Desktop / Workstation (Default)"
echo "  • srv : Headless Server Engine"

read -P "Target environment type? [dsk/srv] (default: dsk): " -l env_input

set -l usecase ""
switch "$env_input"
    case "srv" "server" "2"
        set usecase "srv"
    case "*"
        set usecase "dsk"
end

echo "✅ Target Environment Selected: $usecase"

# ------------------------------------------------------------------------------
# 🧬 Step 3: Automatic Architecture Derivation
# ------------------------------------------------------------------------------
set -l raw_arch (uname -m)
set -l arch ""

switch $raw_arch
    case x86_64
        set arch "x86"
    case arm64 aarch64
        set arch "arm"
    case '*'
        echo "❌ Error: Unsupported architecture ($raw_arch). Must be x86_64 or arm64/aarch64."
        exit 1
end

echo "✅ Architecture Derived: $arch (from $raw_arch)"

# ------------------------------------------------------------------------------
# 📦 Step 3.5: Repository Management & Hardware Configuration
# ------------------------------------------------------------------------------
# Helper function to run git, using nix-shell fallback if git is not installed
function git_cmd
    if command -v git >/dev/null 2>&1
        git $argv
    else if command -v nix-shell >/dev/null 2>&1
        nix-shell -p git --run "git "(string join ' ' (string escape -- $argv))
    else
        echo "❌ Error: git is not installed and nix-shell is not available."
        exit 1
    end
end

set -l repo_dir ""
# Detect if we are already running inside a local clone of bento
if git rev-parse --is-inside-work-tree >/dev/null 2>&1
    set -l git_url (git remote get-url origin 2>/dev/null)
    if string match -r "bento" "$git_url" >/dev/null
        set repo_dir (git rev-parse --show-toplevel 2>/dev/null)
        echo "ℹ️ Running from local clone: $repo_dir"
    end
end

if test -z "$repo_dir"
    set repo_dir "$HOME/.config/bento"
    echo "ℹ️ Bento repository will be managed in $repo_dir"
    if test -d "$repo_dir"
        echo "🔄 Updating existing Bento repository in $repo_dir..."
        git_cmd -C "$repo_dir" pull || echo "⚠️ Warning: git pull failed. Proceeding with existing local copy."
    else
        echo "📥 Cloning Bento repository to $repo_dir..."
        mkdir -p (dirname "$repo_dir")
        git_cmd clone https://github.com/MrGrappleMan/bento.git "$repo_dir"
    end
end

if test "$ostype" = "nx"
    echo "⚙️ Copying hardware configuration from /etc/nixos/hardware-configuration.nix..."
    if test -f /etc/nixos/hardware-configuration.nix
        cp /etc/nixos/hardware-configuration.nix "$repo_dir/linux/hardware-configuration.nix"
        echo "✅ Copy successful."
    else
        echo "⚠️ Warning: /etc/nixos/hardware-configuration.nix not found."
        echo "⚙️ Generating new hardware configuration..."
        sudo nixos-generate-config --show-hardware-config > "$repo_dir/linux/hardware-configuration.nix"
        echo "✅ Generation successful."
    end
    # Ensure the hardware configuration is tracked by git, otherwise nix flakes ignores it
    git_cmd -C "$repo_dir" add linux/hardware-configuration.nix
end

# ------------------------------------------------------------------------------
# 🚀 Step 4: Dynamic Rebuild Phase
# ------------------------------------------------------------------------------
set -l target_attribute "$ostype-$usecase-$arch"

echo ""
echo "🚀 Deploying target attribute: $repo_dir#$target_attribute"
echo "------------------------------------------------------------------------------"

# Require rebooting on NixOS
if test "$ostype" = "nx"
    sudo nixos-rebuild boot \
        --flake "$repo_dir#$target_attribute" \
        --extra-experimental-features "nix-command flakes" \
        --no-write-lock-file \
        --refresh
else
    if test "$ostype" = "dw"
        darwin-rebuild switch \
            --flake "$repo_dir#$target_attribute" \
            --extra-experimental-features "nix-command flakes" \
            --no-write-lock-file \
            --refresh
    fi
end
