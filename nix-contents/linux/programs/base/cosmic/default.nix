
{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    cosmic-app-library
    cosmic-bg
    cosmic-comp
    cosmic-files
    cosmic-greeter
    cosmic-icons
    cosmic-idle
    cosmic-initial-setup
    cosmic-launcher
    cosmic-monitor
    cosmic-notifications
    cosmic-osd
    cosmic-panel
    cosmic-player
    cosmic-protocols
    cosmic-randr
    cosmic-reader
    cosmic-screenshot
    cosmic-session
    cosmic-settings
    cosmic-settings-daemon
    cosmic-sound-theme
    cosmic-store
    cosmic-workspaces-epoch
    cutecosmic
    examine
    libcosmicAppHook
    tasks
    xdg-desktop-portal-cosmic
    cosmic-applets
    cosmic-ext-applet-caffeine
    cosmic-ext-applet-external-monitor-brightness
    cosmic-ext-applet-privacy-indicator
    cosmic-ext-applet-weather
    cosmic-ext-calculator
    cosmic-ext-ctl
    cosmic-ext-tweaks
  ];
  services = {
    desktopManager = {
      cosmic = {
        enable = true;
      };
    };
    displayManager = {
      cosmic-greeter = {
        enable = true;
      };
    };
  };
}