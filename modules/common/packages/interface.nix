{ config, lib, pkgs, ... }:

with lib;

{
  config = {
    # Packages for the thin client/interface with GUI apps use and interaction with the worker
    homebrew = {
      brews = [

      ];
      casks = [

      ];
      masApps = [
        "speedtest-by-ookla" = 1153157709;
      ];
    };
  };
}
