{
  description = "Bento - the productivity suite for MacOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nix-darwin, nixpkgs }@inputs: {
    darwinConfigurations = {
      # Matches 'defaulthost' as used in: github:MrGrappleMan/bento#defaulthost, bypassing the need for a separate hostname
      "defaulthost" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          ./modules/plist # Loads modules/plist/default.nix (system defaults & launchd background sync)
          ./modules/brew  # Loads modules/brew/default.nix (Homebrew baseline & profile toggles)
        ];
      };
    };
  };
}