{
  description = "Bento Productivity Suite - Multi-Device Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nix-darwin, nixpkgs }@inputs: {
    darwinConfigurations = {
      # Replace 'pc-macbook' with your actual mac hostname
      "pc-macbook" = nix-darwin.lib.darwinSystem {
        modules = [
          ./modules/core/system.nix
          ./modules/background-sync.nix
          ./modules/brew
        ];
      };
    };
  };
}