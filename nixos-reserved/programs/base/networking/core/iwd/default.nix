{ config, lib, pkgs, ... }:

{
  networking.wireless.iwd = {
    enable = true;
    
  };
  services.connman.wifi.backend = "iwd";
  networking.networkmanager.wifi.backend = "iwd";
}