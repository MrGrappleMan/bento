# This is a placeholder. The actual hardware configuration will be copied
# from /etc/nixos/hardware-configuration.nix during installation.
# Do not edit this placeholder directly unless you want to use it as a default.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ ];

  # Placeholders to satisfy evaluation if evaluated without being overwritten
  fileSystems."/" = lib.mkDefault {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
  };

  boot.initrd.availableKernelModules = lib.mkDefault [ "xhci_pci" "ehci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = lib.mkDefault [ ];
  boot.kernelModules = lib.mkDefault [ "kvm-intel" ];
  boot.extraModulePackages = lib.mkDefault [ ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
