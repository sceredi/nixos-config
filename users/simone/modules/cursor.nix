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

  home.sessionVariables = {
    XCURSOR_THEME = "Quintom_Ink";
    XCURSOR_SIZE = "36";
    QT_AUTO_SCREEN_SCALE_FACTOR = "0";
  };
}
