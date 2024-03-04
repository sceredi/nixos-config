{ config, lib, pkgs, ... }: {
  gtk.cursorTheme = {
    package = pkgs.quintom-cursor-theme;
    name = "Quintom_Ink";
    size = 36;
  };

  home.pointerCursor = {
    x11.enable = true;
    gtk.enable = true;
    package = pkgs.quintom-cursor-theme;
    name = "Quintom_Ink";
    size = 36;
  };
}
