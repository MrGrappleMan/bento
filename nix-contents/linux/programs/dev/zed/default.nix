{ config, lib, pkgs, ... }:

{
  programs = {
    zed-editor = {
      enable = true;
      extensions = [
        "nix"
        "toml"
        "rust"
      ];
      userSettings = {
        theme = {
          mode = "system";
          dark = "One Dark";
          light = "One Light";
        };
        vim_mode = true;
      };
    };
  };
}