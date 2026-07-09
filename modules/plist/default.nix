{ config, pkgs, ... }: {

  # =========================================================================
  # ⚙️ Native nix-darwin Defaults (Cleanly typed & supported options)
  # =========================================================================
  system.defaults = {
    
    # 🖥️ Dock Preferences
    dock = {
      autohide-delay = 0.0;
      autohide-time-modifier = 0.4;
      mineffect = "scale";
      launchanim = false;
      
      # Hidden key mappings for native animation performance tuning
      expose-animation-duration = 0.0;
    };

    # 🌐 Global User Domain Preferences (-g / NSGlobalDomain)
    NSGlobalDomain = {
      NSAutomaticWindowAnimationsEnabled = false;
      NSWindowResizeTime = 0.001;
      NSAutomaticSpellingCorrectionEnabled = false;
      PMPrintingExpandedStateForPrint = true;
      PMPrintingExpandedStateForPrint2 = true;
    };

    # 📂 Finder Settings
    finder = {
      # Maps your com.apple.LaunchServices LSQuarantine preference natively
      FXLaunchAlerts = true; 
    };

    # 🔒 Advanced Custom Property Overrides (For unsupported native keys)
    CustomUserPreferences = {
      "com.apple.Safari" = {
        HomePage = "https://scidsg.github.io/relaylove/";
        WarnAboutFraudulentWebsites = true;
      };
      "com.apple.desktopservices" = {
        DSDontWriteNetworkStores = false;
        DSDontWriteUSBStores = false;
      };
      "com.apple.frameworks.diskimages" = {
        skip-verify = false;
        skip-verify-locked = false;
        skip-verify-remote = false;
      };
      "com.apple.TextEdit" = {
        RichText = 0; # Just use Notion, Obsidian, or Zed instead!
      };
    };
  };

  # =========================================================================
  # 🛠️ System Activation Scripts (For root/sudo & currentHost preferences)
  # =========================================================================
  system.activationScripts.postUserActivation.text = ''
    echo "⚙️ Tweaking advanced root, hardware, and host-specific settings..."

    # 🛡️ Application Layer Firewall (ALF) - Needs root emulation context
    sudo defaults write /Library/Preferences/com.apple.alf globalstate -int 1
    sudo defaults write /Library/Preferences/com.apple.alf stealthenabled -int 1
    sudo defaults write /Library/Preferences/com.apple.alf allowsignedenabled -int 1

    # 🎛️ Springboard animation tuning
    defaults write com.apple.dock springboard-show-duration -int 0
    defaults write com.apple.dock springboard-hide-duration -int 0

    # 🔤 Font Rendering & Smoothing Adjustments
    defaults write -g CGFontRenderingFontSmoothingDisabled -bool false
    defaults write -currentHost -globalDomain AppleFontSmoothing -int 3

    # 📡 Network and Audio Stack Tuning
    sudo defaults write /Library/Preferences/com.apple.mDNSResponder.plist NoMulticastAdvertisements -bool false
    defaults write bluetoothaudiod "Enable AAC codec" -bool true
    defaults write bluetoothaudiod "Enable AptX codec" -bool true

    # 📊 Diagnostics and Infrastructure 
    defaults write com.apple.appleseed.FeedbackAssistant Autogather -bool true
    sudo defaults write /Library/Preferences/com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true
    sudo defaults write /Library/Preferences/com.apple.windowserver.plist DisplayResolutionEnabled -bool true
  '';
}