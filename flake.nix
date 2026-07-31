{
  description = "Bento - the productivity suite for MacOS";

  inputs = {
    nixpkgs = { 
      url = "github:nixos/nixpkgs/nixpkgs-unstable"; 
    };
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew = {
      url = "github:zhaofengli-wip/nix-homebrew";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nix-darwin, nixpkgs, nix-homebrew, home-manager }@inputs: {
    darwinConfigurations = {
      # Matches 'defaulthost' as used in: github:MrGrappleMan/bento#defaulthost, bypassing the need for a separate hostname and editing this
      "defaulthost" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          nix-homebrew.darwinModules.nix-homebrew
          home-manager.darwinModules.home-manager
          ./modules/brew
          ./modules/defaults
          ./modules/launchctl
          ./modules/misc
          ./modules/pmset
        ];
      };
    };
  };
}