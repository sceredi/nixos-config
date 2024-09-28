{ config, lib, pkgs, inputs, ... }: {
  imports = [ ./modules ];
  home = {
    packages = with pkgs; [
      logseq
      quasselClient
      alsa-utils
      wdisplays
      inkscape
      gimp
      mumble
      zathura
      pavucontrol
      qbittorrent
      thunderbird
      wl-mirror
      signal-desktop
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
    theme.package = pkgs.arc-theme;
    theme.name = "Arc";
    iconTheme.package = pkgs.arc-icon-theme;
    iconTheme.name = "Arc";
  };

  xdg.enable = true;
}
