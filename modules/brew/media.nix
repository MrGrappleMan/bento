{ config, lib, pkgs, ... }:
    
    with lib;
    
    {
      config = {
        homebrew = {
          brews = [
            "ffmpeg"
            "obs"
            "krita"
          ];
          casks = [
            "blender"
          ];
        };
      };
    }