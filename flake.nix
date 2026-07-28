{
  description = "Bento - the productivity suite for MacOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nix-darwin, nixpkgs }@inputs: {
    darwinConfigurations = {
      # 'hostname-here' is matched with your true hostname by nix-darwin, but this is overriden
      "hostname-here" = nix-darwin.lib.darwinSystem {
        modules = [
          ./modules/core/system.nix
          ./modules/background-sync.nix
          ./modules/brew
        ];
      };
    };
  };
}