{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [./modules];
  home = {
    packages = with pkgs; [
      quasselClient
      alsa-utils
      wdisplays
      inkscape
      gimp3
      mumble
      zathura
      pavucontrol
      qbittorrent
      thunderbird
      wl-mirror
    ];
    sessionVariables = {
      TERM = "xterm-256color";
      EDITOR = "nvim";
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "adwaita";
    style = {
      name = "adwaita";
      package = pkgs.adwaita-qt;
    };
  };

  gtk = {
    enable = true;
    gtk4.theme = null;
  };

  xdg.enable = true;
}
