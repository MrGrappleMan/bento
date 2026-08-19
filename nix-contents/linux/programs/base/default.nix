{ config, pkgs, ... }:
{
  imports = [
      ./boinc
      ./brave
      ./core-stuff
      ./cosmic
      ./fish
      ./flatpak
      
    ];
}
