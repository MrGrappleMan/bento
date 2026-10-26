{ config, lib, pkgs, ... }:

with lib;

{
  imports = [

  ];

  # Allow modular installation of package group
  options.bento.profiles = {
    creative.enable = mkEnableOption "Creativity tools";
    cybersec.enable = mkEnableOption "Cybersecurity tools";
  };

  config = {
    nix-homebrew = {
      enable = true;
      enableRosetta = false; # Remove compatibility
      # Enable Homebrew analytics - https://docs.brew.sh/Analytics
      # Helps maintainers fix bugs, saves time, private with only relevant data sent
      enableAnalytics = true;
    };
    # Global homebrew config and packages
    homebrew = {
        enable = true;
        onActivation = {
          autoUpdate = true;
          upgrade = true;
          cleanup = "none";
      };

      # Repositories / Taps - get all for convenience
      taps = [
        "pol-rivero/tap"
        "glzr-io/tap"
        "domt4/autoupdate"
        "homebrew/cask-cask"
        "center2055/onionhop"
        "vaibhav-mattoo/bitchat-tui"
        "teamookla/speedtest"
      ];

      brews = [
        "ollama"
        "ffmpeg"
        "fish"
        "aria2"
        "zoxide"
        "fzf"
        "macfuse"
        "podman"
        "mas" # CLI for App Store interaction
        "defaultbrowser" # Set default browser utility
        "nmap"
        "wireshark"
        "mosh"
        "sshuttle"
        "tailscale"
        "wireguard"
        "tor"
        "snowflake"
        "onionhop"
        "speedtest-cli"
        "ncrack"
        "aircrack-ng"
        "git"
        "git-lfs"
        "jj"
        "jjui"
        "rust"
        "swift"
        "xcode-build-server"
        "python"
        "llvm"
        "gcc"
        "clang"
        "podman-compose"
        "podman-desktop"
        "kubectl"
        "obs"
      ];
      # Common
      casks = [
      "utm"
      "localsend"
      ];
      brews = [
      ];
      # Worker
      casks = [
        "boinc"
      ];
      brews = [
      ];
      # Interface
      casks = [
        "glazewm"
        "zebar"
        "raycast"
        "maintenance"
        "onlyoffice"
        "github-desktop-plus"
        "zed"
        "warp"
        "bitchat-tui"
        "tor-browser@alpha"
        "moonlight"
      ];
      brews = [
      ];
    };
  };
}
