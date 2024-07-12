{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ vim git gnupg pinentry-curses ];
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
      tree

      # Utils
      zip
      xfce.thunar
      file-roller
      xfce.thunar-volman
      xfce.thunar-archive-plugin
      gnome-disk-utility
      gnome-common

      # Screenshots
      shutter
      flameshot

      # Pomodoro Timer
      porsmo

      # Music plyaer
      cmus

      # Android tools
      android-tools
      scrcpy

      # Local file sharing
      localsend
    ];
  };
}
