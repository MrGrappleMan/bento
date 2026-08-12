{

  description = "Bento - the productivity suite for NixOS / MacOS";

  inputs = {
  ./hardware-configuration.nix
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
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nix-cachyos-kernel, nix-darwin, nix-homebrew, home-manager, nixos-hardware, flake-parts, ... }@inputs: {

    # MacOS, x86 support is not supported
    darwinConfigurations = {
      # Desktop aarch64
      "dw-dsk-arm" = nix-darwin.lib.darwinSystem {
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
      # Server aarch64
      "dw-srv-arm" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          #planned later
        ];
      };
    };

    # NixOS
    nixosConfigurations = {
      # Desktop aarch64
      "nx-dsk-arm" = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [
          home-manager.nixosModules.home-manager
          #planned later
        ];
      };
      # Server aarch64
      "nx-srv-arm" = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [
          home-manager.nixosModules.home-manager
          #planned later
        ];
      };
      # Desktop x86_64
      "nx-dsk-x86" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          home-manager.nixosModules.home-manager
          ./linux/boot
          ./linux/flatpak
          ./linux/pkgs
          ./linux/systemd
          ./linux/xdg
        ];
      };
      # Server x86_64
      "nx-srv-x86" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          home-manager.nixosModules.home-manager
          #Planned later
        ];
      };
    };
  };
}
