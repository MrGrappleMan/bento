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

  nix-homebrew = {
      enable = true;
      enableRosetta = false; # Ready for Golden Gate
      # Enable Homebrew analytics - https://docs.brew.sh/Analytics
      # Saves Time: The team knows exactly which tools to update.
      # Stops Errors: They can track which tools fail to install and fix them.
      # Keeps it Safe: The data is anonymous. It only tracks the package name and your command
      enableAnalytics = true; 
  };
  config = {
    # Global homebrew config
    homebrew = {
      enable = true;
      onActivation = {
        autoUpdate = true;
        upgrade = true;
        cleanup = "none"; # Let the user manage cleanup, don't let me wipe your configurations upon package deprecation in here
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