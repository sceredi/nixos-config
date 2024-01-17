{
  systemd.user.services.kanshi = {
    serviceConfig = {
      StartLimitBurst = 5;
      StartLimitIntervalSec = 30;
    };
  };
  services.kanshi = {
    enable = true;
    profiles = {
      undocked = {
        outputs = [{
          criteria = "eDP-1";
          status = "enable";
          mode = "2880x1800@60.001Hz";
          position = "0,0";
          scale = 1.5;
        }];
      };
      docked = {
        outputs = [
          {
            criteria = "eDP-1";
            status = "enable";
            mode = "2880x1800@60.001Hz";
            position = "0,0";
            scale = 1.5;
          }
          {
            criteria = "LG Electronics LG HDR 4K 0x00007E97";
            mode = "3840x2160";
            position = "2880,0";
            scale = 1.0;
          }
        ];
      };
    };
  };
}
