{ config, pkgs, ... }: {

  # =========================================================================
  # ⚙️ System defaults
  # =========================================================================
  system.defaults = {
    
    # 🖥️ Dock Preferences (Only natively supported keys)
    dock = {
      autohide-delay = 0.0;
      autohide-time-modifier = 0.4;
      mineffect = "scale";
      launchanim = false;
      expose-animation-duration = 0.0;
    };

    # 🌐 Global Domain (NSGlobalDomain)
    NSGlobalDomain = {
      NSAutomaticWindowAnimationsEnabled = false;
      NSWindowResizeTime = 0.001;
      NSAutomaticSpellingCorrectionEnabled = false;
      PMPrintingExpandedStateForPrint = true;
      PMPrintingExpandedStateForPrint2 = true;
      
      # Font smoothing keys supported directly by NSGlobalDomain.nix
      AppleFontSmoothing = 3;
      CGFontRenderingFontSmoothingDisabled = false;
    };

    # 📂 Finder Settings
    finder = {
      FXLaunchAlerts = true; 
    };

    # 🚀 LaunchServices Settings (From LaunchServices.nix)
    LaunchServices = {
      LSQuarantine = true;
    };

    # 🔒 Custom User Preferences (~/Library/Preferences/)
    # Used for user domains that lack dedicated nix-darwin module keys
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
        RichText = 1;
      };
      "com.apple.dock" = {
        springboard-show-duration = 0;
        springboard-hide-duration = 0;
      };
      "bluetoothaudiod" = {
        "Enable AAC codec" = true;
        "Enable AptX codec" = true;
      };
      "com.apple.appleseed.FeedbackAssistant" = {
        Autogather = true;
      };
    };
  };

  # =========================================================================
  # 🛠️ System Activation Scripts (ONLY Root / /Library/Preferences Domains)
  # =========================================================================
  system.activationScripts.postUserActivation.text = ''
    echo "⚙️ Tweaking advanced root system preferences..."

    # 🛡️ Application Layer Firewall (ALF) - System level
    sudo defaults write /Library/Preferences/com.apple.alf globalstate -int 1
    sudo defaults write /Library/Preferences/com.apple.alf stealthenabled -int 1
    sudo defaults write /Library/Preferences/com.apple.alf allowsignedenabled -int 1

    # 📡 Network & System Level Configurations
    sudo defaults write /Library/Preferences/com.apple.mDNSResponder.plist NoMulticastAdvertisements -bool false
    sudo defaults write /Library/Preferences/com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true
    sudo defaults write /Library/Preferences/com.apple.windowserver.plist DisplayResolutionEnabled -bool true
  '';
}