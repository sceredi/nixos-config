{ config, lib, pkgs, ... }: {
  gtk.cursorTheme = {
    package = pkgs.quintom-cursor-theme;
    name = "Quintom_Ink";
    size = 36;
  };

  home.pointerCursor = {
    package = pkgs.quintom-cursor-theme;
    name = "Quintom_Ink";
    size = 36;
  };
}
