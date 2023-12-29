{ config, lib, pkgs, ... }:
{
  services.xserver.xkb.extraLayouts.us-but-better = {
    description = "US layout with italian acute and grave vocals in decent positions";
    languages = [ "eng" ];
    symbolsFile = ./symbols/us-but-better;
  };
  
  services.xserver.xkb.extraLayouts.real-prog-qwerty = {
    description = "Real Programmers qwerty layout";
    languages = [ "eng" ];
    symbolsFile = ./symbols/real-prog-qwerty;
  };

  services.xserver = {
    layout = "us-but-better,real-prog-qwerty";
    xkbOptions = "grp:win_space_toggle";
  };

}
