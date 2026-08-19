 { config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    uutils-coreutils
    uutils-util-linux
  ];
}