{ config, pkgs, lib, ... }:

let
  # Dynamically fetch the username executing nix-darwin / darwin-rebuild
  # Fallback to "runner" or "admin" if builtins.getEnv is empty during pure evaluations
  targetUser = 
    let envUser = builtins.getEnv "USER";
    in if envUser != "" then envUser else "admin";
in
{
  # 1. Enable nix-darwin's user management dynamically for targetUser
  users.users.${targetUser} = {
    name = targetUser;
    home = "/Users/${targetUser}";
  };

  # 2. Configure Home Manager dynamically
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    # Pass targetUser and targetHome down to Home Manager submodules
    extraSpecialArgs = {
      inherit targetUser;
      targetHome = "/Users/${targetUser}";
    };

    # Dynamically bind the configuration to targetUser
    users.${targetUser} = { pkgs, ... }: {
      # Matches home-manager state version
      home.stateVersion = "24.05";

      # Recursively map all dotfiles/contents from bento/home-contents/ to ~/
      # Setting 'force = true' ensures pre-existing unmanaged files are overwritten
      home.file = {
        "." = {
          source = ../../home-contents;
          recursive = true;
          force = true; # Force overwrite if target file exists
        };
      };
    };
  };
}