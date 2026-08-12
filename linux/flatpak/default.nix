{ pkgs, ... }:

{
  # 📦 Ensure Flatpak subsystem is activated natively within NixOS core
  services.flatpak = {
    enable = true;

    # 🔄 Automatically drop unmanaged/stale assets to keep storage separate
    uninstallUnmanaged = true;

    # 🌐 Repositories
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

    # 📦 Packages
    package = [
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
  };
}
