#!/usr/bin/env fish

# (@) PKG Distro derived versioning
# Distro-sync - Packages versions are set to the version meant for that version of the distro
# for coordinated versioning.
#
# Updating - Packages are bindly updated, but some may break compatibility
# with each other and not coordinate
#
# You want a system that works correctly,
# and not just packages with a higher version that may not properly coordinate with each other.
# Distro-sync also fixes conflicts and missing dependencies
# May behave abnormally on rawhide versions. This is better for the bootc philosophy, overall.

{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # 🌌 COSMIC Desktop
    cosmic-app-library
    cosmic-bg
    cosmic-comp
    cosmic-files
    cosmic-greeter
    cosmic-icons
    cosmic-idle
    cosmic-initial-setup
    cosmic-launcher
    cosmic-monitor
    cosmic-notifications
    cosmic-osd
    cosmic-panel
    cosmic-player
    cosmic-protocols
    cosmic-randr
    cosmic-reader
    cosmic-screenshot
    cosmic-session
    cosmic-settings
    cosmic-settings-daemon
    cosmic-sound-theme
    cosmic-store
    cosmic-workspaces-epoch
    cutecosmic
    examine
    libcosmicAppHook
    tasks
    xdg-desktop-portal-cosmic
    cosmic-applets
    cosmic-ext-applet-caffeine
    cosmic-ext-applet-external-monitor-brightness
    cosmic-ext-applet-privacy-indicator
    cosmic-ext-applet-weather
    cosmic-ext-calculator
    cosmic-ext-ctl
    cosmic-ext-tweaks

    # 🛠️ Software tools
    zed-editor
    nerd-fonts.zed-mono
      # Shell
        # Terminals
          warp-terminal
        # Zsh
          zsh
          oh-my-zsh
        # Fish
          fish
          oh-my-fish
          fish-lsp
          fishPlugins.plugin-git
    uutils-coreutils
    uutils-util-linux

    # 💾 Storage, Serialization & Sync Toolchains
    zstd
    hblock
    rclone
    rsync
    rquickshare

    # 🕸️ Networking Pipelines & Secure Transport
    tor
    torctl
    snowflake
    openssh
    mosh
    tailscale
    iwd

    # 📦 Containers/environment
    distrobox
    podman
    podman-desktop

    # System
      systemd
      systemdUkify

    # Artificial Intelligence
    ollama

    # BOINC
    boinc

  ];
}
