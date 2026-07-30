{ config, pkgs, ... }: {

  # =========================================================================
  # ⚙️ System defaults
  # =========================================================================
  system.defaults = {
    SoftwareUpdate = {
      AutomaticallyInstallMacOSUpdates = true;
    };

    menuExtraClock = {
      IsAnalog = false;
      ShowAMPM = true;
      ShowDayOfMonth = true;
      ShowDayOfWeek = true;
      ShowSeconds = false; # may drain battery faster
      
    };
    
    # 🖥️ Dock Preferences (Only natively supported keys)
    dock = {
      autohide-delay = 0;
      autohide-time-modifier = 0.4;
      mineffect = "scale";
      launchanim = false;
      expose-animation-duration = 0.0;
      enable-spring-load-actions-on-all-items = true;
      minimize-to-application = true;
      mru-spaces = true;
      orientation = bottom;
      scroll-to-open = true;
      show-process-indicators = true;
      show-recents = false;
      slow-motion-allowed = false;
      static-only = false;
    };

    # 🌐 Global Domain (NSGlobalDomain)
    NSGlobalDomain = {
      NSAutomaticWindowAnimationsEnabled = false;
      NSWindowResizeTime = 0.001;
      PMPrintingExpandedStateForPrint = true;
      PMPrintingExpandedStateForPrint2 = true;
      
      # Font smoothing keys supported directly by NSGlobalDomain.nix
      #AppleFontSmoothing = 3;

      CGFontRenderingFontSmoothingDisabled = false;
    };

    # 📂 Finder Settings
    finder = {
      FXLaunchAlerts = true;
      ShowStatusBar = true;
      ShowPathbar = true;
      FXRemoveOldTrashItems = true; # Auto clear after 30 days
      AppleShowAllExtensions = true;
      CreateDesktop = true; # Allows for quick access to app shortcuts and folders
      QuitMenuItem = false; # Quitting makes desktop icons disappear. Why do macOS and Windows have to tie their file managers to the desktops?
      ShowExternalHardDrivesOnDesktop = true; # Show external hard drives on the desktop
      ShowHardDrivesOnDesktop = true; # For Apple silicon, it may seem pointless, but it also allows fast access to system root ( / )
      ShowMountedServersOnDesktop = true;
      ShowRemovableMediaOnDesktop = true;
      _FXShowPosixPathInTitle = true; # Show full path, easy for Linux users to understand
      FXEnableExtensionChangeWarning = false;
      
    };

    loginwindow = {
      SHOWFULLNAME = false; # Is a hassle if switching users frequently
      GuestEnabled = true;
      ShutDownDisabled = true;
      RestartDisabled = false;
      SleepDisabled = false;
      ShutDownDisabledWhileLoggedIn = true;
      PowerOffDisabledWhileLoggedIn = true;
      RestartDisabledWhileLoggedIn = false;
      DisableConsoleAccess = false;
    };
  
    LaunchServices = {
      LSQuarantine = true;
    };

    screencapture = {
      type = "png";
      disable-shadow = true;
      include-date = true;
      save-selections = true;
      show-thumbnail = true;
    };

    controlcenter = {
      BatteryShowPercentage = true;
      Sound = 18;
      Bluetooth = 18;
      AirDrop = 18;
      Display = 18;
      FocusModes = 18;
      NowPlaying = 18;
    };

    universalaccess = {
      reduceMotion = true;
      reduceTransparency = true;
    };
    
    WindowManager = {
      GloballyEnabled = false; # GlazeWM is in use, this setting is off to prevent conflicts
    };

    # 🔒 
    CustomSystemPreferences = {
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

      com.apple.alf = {
        globalstate = 1;
        stealthenabled = 1;
        allowsignedenabled = 1;
      };

      com.apple.mDNSResponder = {
        NoMulticastAdvertisements = false;
      };

      com.apple.TimeMachine = {
        DoNotOfferNewDisksForBackup = true;
      };

      com.apple.windowserver = {
        DisplayResolutionEnabled = true;
      };
      
    };
  };

}