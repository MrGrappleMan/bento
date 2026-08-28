{ config, pkgs, ... }:

# Guide sheet for system-d users


{
  # User-level services
  launchd.user.agents."com.apple.ReportCrash" = {
    overrideCmdPort = true;
    config = {
      Disabled = false; 
      RunAtLoad = true;
    };
  };

  # System-level services
  launchd.daemons."com.apple.ReportCrash.Root" = {
    overrideCmdPort = true;
    config = {
      Disabled = false;
      RunAtLoad = true;
    };
  };
}
