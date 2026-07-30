{ config, lib, pkgs, ... }:
    
    with lib;
    
    {
      config = {
        # For networking
        homebrew = {
          # Brews
          brews = [
            "ffmpeg"
            "obs"
            "krita"
          ];
          # Casks
          casks = [
            "blender"
          ];
        };
      };
    }