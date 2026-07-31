{ config, lib, pkgs, ... }:

with lib;

{
  imports = [
    ./dev.nix
    ./media.nix
    ./networking.nix
    ./pentest.nix
  ];

  # Allow modular installation of package groups
  options.bento.profiles = {
    dev.enable = mkEnableOption "Software Development tools";
    media.enable = mkEnableOption "Media tools";
    networking.enable = mkEnableOption "Networking & Diagnostic tools";
    pentest.enable = mkEnableOption "Pentesting tools";
  };

  config = {
    # Global homebrew config
    homebrew = {
      enable = true;
      onActivation = {
        autoUpdate = true;
        upgrade = true;
        cleanup = "none"; # Let the user manage cleanup, don't let me wipe your configurations upon package removal
      };

      # General purpose declarations below
      
      # Repositories / Taps
      taps = [
        "pol-rivero/tap"
        "glzr-io/tap"
        "domt4/autoupdate"
        "homebrew/cask-cask"
        "center2055/onionhop"
        "teamookla/speedtest"
      ];
      # Brews
      brews = [
        "fish"
        "aria2"
        "zoxide"
        "fzf"
        "macfuse"
        "ollama"
        "podman" # For BOINC container management
        "mas" # CLI for App Store
      ];
      # Casks
      casks = [
        "utm"
        "localsend"
        "glazewm"
        "zebar"
        "raycast"
        "maintenance"
        "onlyoffice"
        "boinc"
        "bitchat-tui"
        "virtualbox" # For BOINC isolated workloads runtime
      ];
      
      masApps = [
        "speedtest-by-ookla" = 1153157709;
        
      ];
    };
  };
}