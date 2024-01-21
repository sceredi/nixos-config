{
  services.xserver.xkb.extraLayouts.bus = {
    description =
      "US layout with italian acute and grave vocals in decent positions";
    languages = [ "eng" ];
    symbolsFile = ../dotfiles/xdg-config/xkb/symbols/bus;
  };

  services.xserver.xkb.extraLayouts.rpq = {
    description = "Real Programmers qwerty layout";
    languages = [ "eng" ];
    symbolsFile = ../dotfiles/xdg-config/xkb/symbols/rpq;
  };

  services.xserver = {
    enable = true;
    layout = "rpq,bus";
    xkbOptions = "caps:escape,grp:win_space_toggle";
  };
}
