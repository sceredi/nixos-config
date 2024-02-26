{ config, pkgs, lib, inputs, ... }: {
  environment.systemPackages = with pkgs; [ vim git ];
  nix = {
    settings = {
      trusted-users = [ "@wheel" "root" ];
      auto-optimise-store = true;
    };
  };
  home-manager.users.simone = { pkgs, ... }: {
    home.packages = with pkgs; [
      # Command Line
      tldr
      neofetch
      gnugrep
      gnused
      killall
      libnotify
      bat
      eza
      fd
      bottom
      ripgrep
      htop
      hwinfo
      unzip
      fzf

      # Utils
      xfce.thunar
      xfce.thunar-volman
      xfce.thunar-archive-plugin
      gnome.gnome-disk-utility
      gnome.gnome-common

      # Screenshots
      shutter
      flameshot
    ];
  };
}
