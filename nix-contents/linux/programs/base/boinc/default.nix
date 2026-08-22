{ config, pkgs, ... }:

{
  # Core service
  services.boinc = {
    enable = true;
    extraEnvPackages = with pkgs; [
      virtualbox # For VirtualBox based containerized tasks
      linuxPackages.nvidia_x11 # For CUDA processing
      ocl-icd # OpenCL support for GPU tasks
    ];
    allowRemoteGuiRpc = false; # Prevent remote GUI RPC for non dataDir/remote_hosts.cfg hosts
  };

  # Create the boinc user and grant access to Video and Render groups for GPU computing
  users.users.boinc = {
    enable = true;
    extraGroups = [ "video" "render" ];
    linger = true; # Not needed, but included for completeness
    # Securely map Sub-UIDs/GIDs (Only include this if running containerized tasks)
    subUidRanges = [{ startUid = 100000; count = 65536; }];
    subGidRanges = [{ startGid = 100000; count = 65536; }];
  };
}

#<acct_mgr_login>
#    <authenticator>86538_811dfb74da4e51f4baf5fd808ea992ab</authenticator>
#</acct_mgr_login>

#<acct_mgr>
#    <name>Science United</name>
#    <url>https://scienceunited.org/</url>
#</acct_mgr>
