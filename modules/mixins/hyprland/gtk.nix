{
  lib,
  pkgs,
  ...
}: {
  home.pointerCursor = {
    package = lib.mkForce pkgs.bibata-cursors;
    name = lib.mkForce "Bibata-Modern-Classic";
    size = lib.mkForce 16;
    gtk.enable = true;
    x11.enable = true;
  };

  gtk = {
    gtk2.configLocation = "/home/simone/.config/gtk-2.0/gtkrc";

    iconTheme = {
      name = lib.mkForce "Adwaita";
      package = lib.mkForce pkgs.adwaita-icon-theme;
    };

    theme = {
      name = lib.mkForce "adw-gtk3-dark";
      package = lib.mkForce pkgs.adw-gtk3;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = lib.mkForce "gtk3";
    style.name = lib.mkForce "adwaita-dark";
  };

  home.sessionVariables = {
    XCURSOR_THEME = lib.mkForce "Bibata-Modern-Classic";
    XCURSOR_SIZE = lib.mkForce "16";
  };

  xdg.configFile."gtk-4.0/gtk.css".enable = lib.mkForce false;
}
