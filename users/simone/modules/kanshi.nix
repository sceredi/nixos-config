{ config, pkgs, ... }:
{
  systemd.user.services.kanshi = {
    serviceConfig = {
      StartLimitBurst = 5;
      StartLimitIntervalSec = 30;
    };
  };
  home.packages = [ pkgs.kanshi ];
  services.kanshi = {
    enable = true;
    settings = [
      {
        profile = {
          name = "undocked";
          outputs = [
            {
              criteria = "eDP-1";
              status = "enable";
              mode = "2880x1800@60.001Hz";
              position = "0,0";
              scale = 1.25;
            }
          ];
        };
      }
      {
        profile = {
          name = "docked";
          outputs = [
            {
              criteria = "eDP-1";
              status = "enable";
              mode = "2880x1800@60.001Hz";
              position = "0,720";
              scale = 1.25;
            }
            {
              criteria = "LG Electronics LG HDR 4K 0x00007E97";
              mode = "3840x2160";
              position = "2304,0";
              scale = 1.0;
            }
          ];
        };
      }
    ];
  };
}
