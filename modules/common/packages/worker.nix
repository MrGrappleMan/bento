{ config, lib, pkgs, ... }:

with lib;

{
  config = {
    # Packages for the worker meant for HPC, containers, VMs and AI
    homebrew = {
      brews = [

      ];
      casks = [

      ];
    };
  };
}
