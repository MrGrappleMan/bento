{ config, lib, pkgs, ... }:

with lib;

{
  config = {
    # For software development
    homebrew = {
      # Brews
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
        "podman"
        "podman-compose"
        "podman-desktop"
        "kubectl"
      ];
      # Casks
      casks = [
        "github-desktop-plus"
        "zed"
        "warp"
      ];
    };
  };
}