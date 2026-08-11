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
# 🚀 Step 4: Dynamic Rebuild Phase
# ------------------------------------------------------------------------------
set -l target_attribute "$ostype-$usecase-$arch"

echo ""
echo "🚀 Deploying target attribute: github:MrGrappleMan/bento#$target_attribute"
echo "------------------------------------------------------------------------------"

if test "$ostype" = "nx"
    sudo nixos-rebuild switch \
        --flake "github:MrGrappleMan/bento#$target_attribute" \
        --extra-experimental-features "nix-command flakes" \
        --no-write-lock-file \
        --refresh
else if test "$ostype" = "dw"
    darwin-rebuild switch \
        --flake "github:MrGrappleMan/bento#$target_attribute" \
        --extra-experimental-features "nix-command flakes" \
        --no-write-lock-file \
        --refresh
end
