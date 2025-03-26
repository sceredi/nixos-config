{ config, pkgs, ... }:
{
  systemd.user.services = {
    nm-applet = {
      description = "Network manager applet";

      wantedBy = [ "graphical-session.target" ];
      partOf = [ "graphical-session.target" ];

      serviceConfig.ExecStart = "${pkgs.networkmanagerapplet}/bin/nm-applet";
    };
  };
}
