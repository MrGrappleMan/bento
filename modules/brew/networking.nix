{ config, lib, pkgs, ... }:

with lib;

{
  config = {
    # For networking
    homebrew = {
      # Brews
      brews = [
        "nmap"
        "wireshark"
        "mosh"
        "sshuttle"
        "tailscale"
        "wireguard"
        "tor"
        "snowflake"
        "onionhop"
      ];
      # Casks
      casks = [
        "tor-browser@alpha"
        "moonlight"
        "bitchat-tui"
      ];
    };
  };
}