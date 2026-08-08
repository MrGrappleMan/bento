{ config, lib, pkgs, ... }:

with lib;

{
  config = {
    homebrew = {
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
        "speedtest-cli"
      ];
      casks = [
        "tor-browser@alpha"
        "moonlight"
        "bitchat-tui"
      ];
    };
  };
}