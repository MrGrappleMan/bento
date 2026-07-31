{ config, pkgs, ... }:

{
  # Manage the user-level LaunchAgent
  launchd.user.agents."com.apple.ReportCrash" = {
    overrideCmdPort = true;
    config = {
      Disabled = false; # Set to true if your goal was to disable it
      RunAtLoad = true;
    };
  };

  # Manage the system-level LaunchDaemon
  launchd.daemons."com.apple.ReportCrash.Root" = {
    overrideCmdPort = true;
    config = {
      Disabled = false; # Set to true if your goal was to disable it
      RunAtLoad = true;
    };
  };
}
