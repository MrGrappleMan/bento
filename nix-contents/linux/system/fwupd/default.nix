{ config, lib, pkgs, ... }:

{ 
  services.fwupd = {
    enable = true;
    extraRemotes = [ "lvfs" "lvfs-testing" ];
  };
}