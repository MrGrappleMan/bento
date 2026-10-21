# 🍥 Bento

Workstation focused MacOS nix configuration repository for performance, \
productivity and energy efficiency.

## ⚠️ Requirements

- Apple Silicon
- Authentic macOS, non hackintosh
- System Integrity Protection present, csrutil enabled
- Latest macOS version, beta doesn't matter
- Part of sudoers/admin access
- Single user, this breaks on multi user setups

## ✨ Modes and expected setup

1. Interface

- The main workstation you physically interact with
- Acts as an interface for the workstation
- Prefer a Macbook Air or Neo
- Compatible with Macbook Pros

2. Worker

- An AC only powered Mac
- Runs heavy AI/compilation/rendering workloads
- Preferably headless and Ethernet connected
- Treated as a part of your 24/7 homelab
- FileVault off, auto login on
- Have a screen sharing client for tasks that require a GUI
- Prefer a Mac Mini or Mac Studio
- Compatible with iMacs

## ⚙️ Installation

Run this in any terminal, follow the instructions, then reboot after \
installation to apply changes

```zsh
zsh -c "$(curl -H "Cache-Control: no-cache, no-store, must-revalidate" -H "Pragma: no-cache" -H "Expires: 0" -sSL https://raw.githubusercontent.com/MrGrappleMan/bento/refs/heads/main/start.sh)"
```
