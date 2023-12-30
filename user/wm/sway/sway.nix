{ config, lib, pkgs, stdenv, toString, browser, term, spawnEdigor, font, ... }:
{
  imports = 
  [
    ../../app/terminal/kitty.nix
  ];

  
  wayland.windowManager.sway = {

  };

}
