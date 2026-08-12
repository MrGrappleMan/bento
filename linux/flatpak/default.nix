{ pkgs, ... }:

{
  # 📦 Ensure Flatpak subsystem is activated natively within NixOS core
  services = {
    flatpak = {
      enable = true;
      package = [
        # Runtimes / SDKs / Libraries
        "org.freedesktop.Platform.VulkanLayer.lsfgvk//25.08"
        "org.freedesktop.Platform.VulkanLayer.gamescope"
        "org.freedesktop.Platform.VulkanLayer.MangoHud"
        "org.freedesktop.Platform.VulkanLayer.OBSVkCapture"
        "org.freedesktop.Platform.VulkanLayer.vkBasalt"

        # Applications
        "com.rafaelmardojai.Blanket"
        "io.github.flattool.Warehouse"
        "com.github.tchx84.Flatseal"
        "org.gnome.Boxes"
        "com.ranfdev.DistroShelf"
        "com.nuclearplayer.Nuclear"
        "com.spotify.Client"
        "com.warlordsoftwares.youtube-downloader-4ktube"
        "io.github.ecotubehq.player"
        "org.onlyoffice.desktopeditors"
        "io.ente.auth"
        "io.frama.tractor.carburetor"
        "io.github.nozwock.Packet"
        "org.localsend.localsend_app"
        "com.brave.Browser"
        "io.github.qwersyk.Newelle"
        "org.kde.krita"
        "org.upscayl.Upscayl"
        "org.telegram.desktop"
        "io.github.tobagin.karere"
        "org.equicord.equibop"
        "org.gnome.Fractal"
        "rocks.shy.VacuumTube"
      ];
    };
  };
}
# 🌐 Repositories
#remotes = [
#  { name = "flathub"; location = "https://dl.flathub.org/repo/flathub.flatpakrepo"; }
#  { name = "flathub-beta"; location = "https://dl.flathub.org/beta-repo/flathub-beta.flatpakrepo"; }
#  { name = "cosmic"; location = "https://apt.pop-os.org/cosmic/cosmic.flatpakrepo"; }
#  { name = "gnome-nightly"; location = "https://nightly.gnome.org/gnome-nightly.flatpakrepo"; }
#  { name = "igalia"; location = "https://software.igalia.com/flatpak-refs/igalia.flatpakrepo"; }
#  { name = "eos-apps"; location = "https://ostree.endlessm.com/ostree/eos-apps"; }
#  { name = "eos-sdk"; location = "https://ostree.endlessm.com/ostree/eos-sdk"; }
#  { name = "webkit"; location = "https://software.igalia.com/flatpak-refs/webkit-sdk.flatpakrepo"; }
#  { name = "webkit-sdk"; location = "https://software.igalia.com/flatpak-refs/webkit-sdk.flatpakrepo"; }
#  { name = "fedora"; location = "oci+https://registry.fedoraproject.org"; }
#  { name = "fedora-testing"; location = "oci+https://registry.fedoraproject.org/#testing"; }
#  { name = "rhel"; location = "https://flatpaks.redhat.io/rhel.flatpakrepo"; }
#  { name = "appcenter"; location = "https://flatpak.elementary.io/repo.flatpakrepo"; }
#  { name = "pureos"; location = "https://store.puri.sm/repo/stable/pureos.flatpakrepo"; }
#];
