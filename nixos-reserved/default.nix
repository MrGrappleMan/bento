# In dnf5, distro-sync, pkg versions follow the latest suitable compatible version meant for the distro
#
# Updating - Packages are bindly updated, but some may break compatibility
# with each other and not coordinate
#
# You want a system that works correctly,
# and not just packages with a higher version that may not properly coordinate with each other.
# Distro-sync also fixes conflicts and missing dependencies
# Avoid on rawhide. This is better for the bootc philosophy, overall.

{ config, lib, pkgs, ... }:

{
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };
  environment.systemPackages = with pkgs; [
    

    # 🛠️ Software tools
    zed-editor
    nerd-fonts.zed-mono
      # Shell
        # Terminals
          
        # Zsh
          oh-my-zsh
        # Fish
          oh-my-fish
          fish-lsp
          fishPlugins.plugin-git
    

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
