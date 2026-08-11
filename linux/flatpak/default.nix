{ config, lib, pkgs, ... }:

let
  cfg = config.satellites.flatpak-apps;
in {
  options.satellites.flatpak-apps = {
    enable = lib.mkEnableOption "Declarative system-wide Flatpak runtime application layer";
  };

  config = lib.mkIf cfg.enable {
    # 📦 Ensure Flatpak subsystem is activated natively within NixOS core
    services.flatpak.enable = true;

    # ❄️ Wires declarative remotes and targets using nix-flatpak primitives
    services.flatpak = {
      # 🔄 Automatically drop unmanaged/stale assets to keep storage separate
      uninstallUnmanaged = true;

      # 🌐 Declarative Repositories (Replaces 'fpkr1')
      remotes = [
        { name = "flathub"; location = "https://dl.flathub.org/repo/flathub.flatpakrepo"; }
        { name = "flathub-beta"; location = "https://dl.flathub.org/beta-repo/flathub-beta.flatpakrepo"; }
        { name = "cosmic"; location = "https://apt.pop-os.org/cosmic/cosmic.flatpakrepo"; }
        { name = "gnome-nightly"; location = "https://nightly.gnome.org/gnome-nightly.flatpakrepo"; }
        { name = "igalia"; location = "https://software.igalia.com/flatpak-refs/igalia.flatpakrepo"; }
        { name = "eos-apps"; location = "https://ostree.endlessm.com/ostree/eos-apps"; }
        { name = "eos-sdk"; location = "https://ostree.endlessm.com/ostree/eos-sdk"; }
        { name = "webkit"; location = "https://software.igalia.com/flatpak-refs/webkit-sdk.flatpakrepo"; }
        { name = "webkit-sdk"; location = "https://software.igalia.com/flatpak-refs/webkit-sdk.flatpakrepo"; }
        { name = "fedora"; location = "oci+https://registry.fedoraproject.org"; }
        { name = "fedora-testing"; location = "oci+https://registry.fedoraproject.org/#testing"; }
        { name = "rhel"; location = "https://flatpaks.redhat.io/rhel.flatpakrepo"; }
        { name = "appcenter"; location = "https://flatpak.elementary.io/repo.flatpakrepo"; }
        { name = "pureos"; location = "https://store.puri.sm/repo/stable/pureos.flatpakrepo"; }
      ];

      # 📦 Declarative Package Ingestion
      packages = [
        # Vulkan / Gaming Backend Extension Matrix
        "flathub:org.freedesktop.Platform.VulkanLayer.lsfgvk//25.08"
        "flathub:org.freedesktop.Platform.VulkanLayer.lsfgvk//24.08"
        "flathub:org.freedesktop.Platform.VulkanLayer.gamescope"
        "flathub:org.freedesktop.Platform.VulkanLayer.MangoHud"
        "flathub:org.freedesktop.Platform.VulkanLayer.OBSVkCapture"
        "flathub:org.freedesktop.Platform.VulkanLayer.vkBasalt"

        # Application Layer
        "flathub:com.rafaelmardojai.Blanket"
        "flathub:io.github.flattool.Warehouse"
        "flathub:com.github.tchx84.Flatseal"
        "flathub:org.gnome.Boxes"
        "flathub:com.ranfdev.DistroShelf"
        "flathub:com.nuclearplayer.Nuclear"
        "flathub:com.spotify.Client"
        "flathub:com.warlordsoftwares.youtube-downloader-4ktube"
        "flathub:io.github.ecotubehq.player"
        "flathub:org.onlyoffice.desktopeditors"
        "flathub:io.ente.auth"
        "flathub:io.frama.tractor.carburetor"
        "flathub:io.github.nozwock.Packet"
        "flathub:org.localsend.localsend_app"
        "flathub:com.brave.Browser"
        "flathub:io.github.qwersyk.Newelle"
        "flathub:org.kde.krita"
        "flathub:org.upscayl.Upscayl"
        "flathub:org.telegram.desktop"
        "flathub:io.github.tobagin.karere"
        "flathub:org.equicord.equibop"
        "flathub:org.gnome.Fractal"
        "flathub:rocks.shy.VacuumTube"
      ];

        # Optional structural blueprint template for sandboxing VacuumTube overrides:
        # "rocks.shy.VacuumTube" = {
        #   filesystems = [
        #     "~/.config/lsfg-vk:create"
        #     "~/local/share/Steam/steamapps/common:ro"
        #   ];
        #   environment = {
        #     "LSFGVK_CONFIG" = "~/.config/lsfg-vk/conf.toml";
        #   };
        # };
      };
    };

    # 🐚 Shell Integration Layer: Native Fish Interactive Aliases
    programs.fish.interactiveShellInit = ''
      # Native bindings passing system-level evaluation hooks
      alias fpk "flatpak --system"
      alias fpkr1 "flatpak --system remote-add --if-not-exists"
      alias fpkr0 "flatpak --system remote-delete --force"
      alias fpkp1 "flatpak --system install -y --noninteractive --or-update"
      alias fpkp0 "flatpak --system uninstall -y --noninteractive"
    ''
  }
}
