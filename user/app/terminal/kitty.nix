{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    kitty
  ];
  programs.kitty.enable = true;
  programs.kitty.settings = {
# TODO: Setup kitty
  };
}
