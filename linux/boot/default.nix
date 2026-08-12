{ pkgs, ... }:

{
  # 🚀 Bootloader Configuration: systemd-boot (UEFI)
  boot.loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = 10; # 🧹 Keeps EFI partition clean from stale generations
      consoleMode = "max";      # 🖥️ Optimal screen resolution for boot menu
    };
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot"; # 📍 Ensure this matches fileSystems."/boot"
    };
    grub.enable = false; # 🚫 Explicitly disable GRUB
  };
}
