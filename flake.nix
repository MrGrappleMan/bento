{
  description = "A MacOS productivity suite";

  inputs = {
    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/main.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixai.url = "github:olafkfreund/nix-ai-help";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nix-darwin, nix-homebrew, home-manager, flake-parts, ... }@inputs: {

    darwinConfigurations = {
      "worker" = nix-darwin.lib.darwinSystem {
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
      "interface"
    };
  };
}
