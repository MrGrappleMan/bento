#!/usr/bin/env fish
echo "🚩 --- Run 'dnf5.fish' ---"

# DNF5: Install only essential pkgs to the immutable base

### Notes:
# Always update system before installing packages.
# COSMIC - Modern DE, better performance and efficiency

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

        xdg-desktop-portal flatpak flatseal flatpak-libs flatpak-selinux flatpak-session-helper libportal \
        tuned tuned-ppd tuned-utils-systemtap \
        rsync iwd \
        kmod-ryzen-smu kernel-modules-extra


cosmic-app-library cosmic-bg cosmic-comp cosmic-files cosmic-greeter cosmic-icons cosmic-idle cosmic-initial-setup cosmic-launcher cosmic-monitor cosmic-notifications \
cosmic-osd cosmic-panel cosmic-player cosmic-protocols cosmic-randr cosmic-reader cosmic-screenshot cosmic-session cosmic-settings cosmic-settings-daemon cosmic-sound-theme cosmic-store \
cosmic-workspaces-epoch cutecosmic examine libcosmicAppHook tasks xdg-desktop-portal-cosmic

cosmic-applets cosmic-ext-applet-caffeine cosmic-ext-applet-external-monitor-brightness cosmic-ext-applet-privacy-indicator cosmic-ext-applet-weather
cosmic-ext-calculator cosmic-ext-ctl cosmic-ext-tweaks

warp-terminal
zed-editor nerd-fonts.zed-mono
zsh oh-my-zsh
fish oh-my-fish fish-lsp fishPlugins.plugin-git
zstd
hblock
rclone rsync
tor torctl snowflake
openssh mosh
tailscale
distrobox podman podman-desktop
uutils-coreutils uutils-util-linux
iwd

# Install your dev apps by flatpak or to distrobox,
#amd-gpu-firmware amd-ucode-firmware amdsmi am-utils
#nvidia-gpu-firmware libva-nvidia-driver envytools nvidia-patch
#host-spawn libei libei-utils
#pnpm
#qemu-kvm qemu-kvm-core libvirt-daemon-kvm
#mesa-va-drivers-freeworld mesa-vdpau-drivers-freeworld mesa-vulkan-drivers-freeworld mesa-dri-drivers mesa-va-drivers mesa-vdpau-drivers mesa-vulkan-drivers mesa-libOSMesa mesa-compat-libOSMesa
## CONFLICTS ## ( Format: ChosenPackages | ConflictingPackages (reason) )
# NONE | fedora-release-identity-cosmic-atomic fedora-release-cosmic-atomic ( this independent image is NOT cosmic atomic, recognizing it as one will cause conflicts )
# NONE | fedora-repos-rawhide ( only use repos in fsroot/usr/share/factory/etc/yum.repos.d or pre-packaged ones )
# NONE | cosmic-config-fedora ( We have our own configs )
# tuned tuned-ppd | power-profiles-daemon , tlp tlp-pd tlp-rdw , auto-cpufreq ( TuneD better integrated w/ modern standards, drivers, pstate support, less breakage points by low configurability )
