{ lib, ... }: {
  services.flatpak = {
    enable = true;
    remotes = lib.mkOptionDefault [{
      name = "flathub";
      location = "https://flathub.org/repo/flathub.flatpakrepo";
    }];
    packages = [ "md.obsidian.Obsidian" "org.kde.okular" ];
  };
  xdg.portal.enable = true;
}
