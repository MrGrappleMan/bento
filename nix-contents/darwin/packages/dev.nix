{ config, lib, pkgs, ... }:

with lib;

{
  config = {
    homebrew = {
      brews = [
        "git"
        "git-lfs"
        "jj"
        "jjui"
        "rust"
        "swift"
        "xcode-build-server"
        "python"
        "llvm"
        "gcc"
        "clang"
        "podman-compose"
        "podman-desktop"
        "kubectl"
      ];
      casks = [
        "github-desktop-plus"
        "zed"
        "warp"
      ];
    };
  };
}