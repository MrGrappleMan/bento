{ config, lib, pkgs, ... }:

{
  services = {
    flatpak = {
      enable = true;

      # Automatic Updates
      update = {
        onActivation = true;
        auto = {
          enable = true;
          onCalendar = "daily";
        };
      };

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
    };
  };
}