{
  description = "Bento - the productivity suite for MacOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
  };

  outputs = { self, nix-darwin, nixpkgs }@inputs: {
    darwinConfigurations = {
      # Matches 'defaulthost' as used in: github:MrGrappleMan/bento#defaulthost, bypassing the need for a separate hostname
      "defaulthost" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
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