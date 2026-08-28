{ pkgs, ... }:

{
  # 🚀 Bootloader Configuration: systemd-boot (UEFI)
  boot.loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = 8; # 🧹 Limit max nix generations
      consoleMode = "max";      # 🖥️ 
    };
    grub.enable = false; # 🚫 Explicitly disable GRUB
  };
}
