{ config, lib, pkgs, ... }:
{
  home.packages = with pkgs; [
    neofetch
    libnotify
    unzip
    fd
    unzip
    tmux
  ];
}
