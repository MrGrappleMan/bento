# 🍥 Bento

Workstation focused MacOS nix configuration repository for performance, \
productivity and energy efficiency.

## ⚠️ Requirements

- Apple Silicon
- Authentic macOS, non hackintosh
- System Integrity Protection present, csrutil enabled
- Latest macOS version, beta doesn't matter

## ✨ Modes and expected setup

1. Thin Client

- The main workstation 
- Either a Macbook Air or Neo

2. Powerhouse

- An AC only powered Mac
- Preferably headless and Ethernet connected
- Treated as a part of your 24/7 homelab
- 

## ⚙️ Installation

Run this in any terminal and then reboot after installation to apply changes

```zsh
zsh -c "$(curl -H "Cache-Control: no-cache, no-store, must-revalidate" -H "Pragma: no-cache" -H "Expires: 0" -sSL https://raw.githubusercontent.com/MrGrappleMan/bento/refs/heads/main/start.sh)"
```
