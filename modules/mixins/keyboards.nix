{
  services.xserver = {
    enable = true;
    xkb = {
      layout = "bus,rpq";
      options = "caps:escape,grp:win_space_toggle";
      extraLayouts.bus = {
        description =
          "US layout with italian acute and grave vocals in decent positions";
        languages = [ "eng" ];
        symbolsFile = ../dotfiles/xdg-config/xkb/symbols/bus;
      };
      extraLayouts.rpq = {
        description = "Real Programmers qwerty layout";
        languages = [ "eng" ];
        symbolsFile = ../dotfiles/xdg-config/xkb/symbols/rpq;
      };
    };
  };
}
