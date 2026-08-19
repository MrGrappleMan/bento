# ==============================================================================
# Bento Satellite Module: Declarative Service Orchestration Ledger
# Purpose: Eradicates imperative systemd management loops with pure state mapping.
# ==============================================================================
{ config, lib, pkgs, ... }:

{
  systemd = {
    # Services
    services = {
      power-profiles-daemon = {
        enable = false;
      };
      tlp = {
        enable = false;
      };
      tlp-pd = {
        enable = false;
      };
      auto-cpufreq = {
        enable = false;
      };

      # Core System Service Targets
      systemd-timesyncd = {
        wantedBy = [ "multi-user.target" ];
      };
      greetd = {
        wantedBy = [ "multi-user.target" ];
      };

      # Container & Virtualization Substrates
      podman = {
        wantedBy = [ "multi-user.target" ];
      };
      libvirtd = {
        wantedBy = [ "multi-user.target" ];
      };

      # Radio and Network Pipeline Elements
      systemd-rfkill = {
        wantedBy = [ "multi-user.target" ];
      };
      iwd = {
        wantedBy = [ "multi-user.target" ];
      };
      tailscaled = {
        wantedBy = [ "multi-user.target" ];
      };
      tor = {
        wantedBy = [ "multi-user.target" ];
      };
      sshd = {
        wantedBy = [ "multi-user.target" ];
      };

      # Tuning Mechanics & Custom Schedulers
      tuned = {
        wantedBy = [ "multi-user.target" ];
      };
      tuned-ppd = {
        wantedBy = [ "multi-user.target" ];
      };
      scx_loader = {
        wantedBy = [ "multi-user.target" ];
      };
      systemd-bsod = {
        wantedBy = [ "multi-user.target" ];
      };

      # Dynamic Storage and Maintenance Workers [⚠️toVerify]
      "beesd@var-home" = {
        wantedBy = [ "multi-user.target" ];
      };
    };

    # ⏱️ Timers
    timers = {
      podman-auto-update = {
        wantedBy = [ "timers.target" ];
      };
      uupd = {
        wantedBy = [ "timers.target" ];
      };
      bootc-fetch-apply-updates = {
        wantedBy = [ "timers.target" ];
      };
      fstrim = {
        wantedBy = [ "timers.target" ];
      };
      hblock = {
        wantedBy = [ "timers.target" ];
      };
    };

    # 🔌 Sockets
    sockets = {
      podman = {
        wantedBy = [ "sockets.target" ];
      };
      libvirtd = {
        wantedBy = [ "sockets.target" ];
      };
      systemd-rfkill = {
        wantedBy = [ "sockets.target" ];
      };
    };
  };
}
