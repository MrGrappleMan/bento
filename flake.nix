{

  description = "Bento - the productivity suite for NixOS / MacOS";

  inputs = {
    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/main.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixai.url = "github:olafkfreund/nix-ai-help";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nix-cachyos-kernel = {
      url = "github:xddxdd/nix-cachyos-kernel/release";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:nixos/nixos-hardware";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nix-cachyos-kernel, nix-darwin, nix-homebrew, home-manager, nixos-hardware, nix-flatpak, flake-parts, ... }@inputs: {

    # MacOS, x86 support not practical
    darwinConfigurations = {
      # aarch64
      "dw-arm" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          nix-homebrew.darwinModules.nix-homebrew
          home-manager.darwinModules.home-manager
          ./darwin/brew
          ./darwin/defaults
          ./darwin/launchctl
          ./darwin/misc
          ./darwin/pmset
        ];
      };
    };

    # NixOS
    nixosConfigurations = {
      # x86_64
      "nx-x86" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          home-manager.nixosModules.home-manager
          nix-flatpak.nixosModules.nix-flatpak
          lix-module.nixosModules.default
          ./linux/customcfgs/hardware-configuration.nix
          ./linux/boot
          ./linux/flatpak
          ./linux/pkgs
          ./linux/systemd
          ./linux/xdg
        ];
      };
    };
  };
}
