# ==============================================================================
# Bento Satellite Module: Declarative Service Orchestration Ledger
# Purpose: Eradicates imperative systemd management loops with pure state mapping.
# ==============================================================================
{ config, lib, pkgs, ... }:

{
  systemd = {
    maskedServices = [
      "power-profiles-daemon"
      "tlp"
      "tlp-pd"
      "auto-cpufreq"
      "wpa_supplicant"
    ];

    # 🟢 Active Systemd Workloads (Replaces 'sysdOn' / 'sysdOff' parameters)
    services = {
      # Explicitly disables GDM from matching structural runtime generation hooks
      gdm.wantedBy = lib.mkForce [ ];

      # Core System Service Targets
      systemd-timesyncd.wantedBy = [ "multi-user.target" ];
      greetd.wantedBy = [ "multi-user.target" ];

      # Container & Virtualization Substrates
      podman.wantedBy = [ "multi-user.target" ];
      libvirtd.wantedBy = [ "multi-user.target" ];

      # Radio and Network Pipeline Elements
      systemd-rfkill.wantedBy = [ "multi-user.target" ];
      iwd.wantedBy = [ "multi-user.target" ];
      tailscaled.wantedBy = [ "multi-user.target" ];
      tor.wantedBy = [ "multi-user.target" ];
      sshd.wantedBy = [ "multi-user.target" ];

      # Tuning Mechanics & Custom Schedulers
      tuned.wantedBy = [ "multi-user.target" ];
      tuned-ppd.wantedBy = [ "multi-user.target" ];
      scx_loader.wantedBy = [ "multi-user.target" ];
      systemd-bsod.wantedBy = [ "multi-user.target" ];

      # Dynamic Storage and Maintenance Workers [⚠️toVerify]
      "beesd@var-home".wantedBy = [ "multi-user.target" ];
    };

    # ⏱️ TImers
    timers = {
      podman-auto-update.wantedBy = [ "timers.target" ];
      uupd.wantedBy = [ "timers.target" ];
      bootc-fetch-apply-updates.wantedBy = [ "timers.target" ];
      fstrim.wantedBy = [ "timers.target" ];
      hblock.wantedBy = [ "timers.target" ];
    };

    # 🔌 Sockets
    sockets = {
      podman.wantedBy = [ "sockets.target" ];
      libvirtd.wantedBy = [ "sockets.target" ];
      systemd-rfkill.wantedBy = [ "sockets.target" ];
    };
  };
}
