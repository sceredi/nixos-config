{ config, lib, pkgs, ...}:{
  services.xserver.windowManager.dwm.package = pkgs.dwm.overrideAttrs {
    src = ./dwm;
  };

}
