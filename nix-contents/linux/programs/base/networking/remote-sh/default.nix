{ config, lib, pkgs, ... }:

{
  services.openssh = {
    enable = true;
    settings = {
       PermitRootLogin = "prohibit-password"; # Password root login disabled
       PasswordAuthentication = false; # Key based authentication only
    };
  };
  programs.mosh.enable = true;
}