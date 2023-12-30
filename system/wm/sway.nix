{ config, lib, pkgs, ... }: 
{
  imports = 
  [
    ./wayland.nix
    ./pipewire.nix
    ./dbus.nix
  ];

  programs = {
    sway = {
      enable = true;
      xwayland.enable = true;
      portalPackages = pkgs.xdg-desktop-portal-sway;
    };
  };
}
