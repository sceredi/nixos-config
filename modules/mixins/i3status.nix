{ pkgs, config, ... }: {
  home-manager.users.simone = { pkgs, ... }: {
    home.packages = with pkgs; [ networkmanager ];
    programs.i3status-rust = {
      enable = true;
      bars = {
        top = {
          blocks = [
            {
              block = "memory";
              format = " $icon $mem_used_percents ";
              format_alt = " $icon $swap_used_percents ";
              theme_overrides = { idle_bg = "#00223f"; };
            }
            {
              block = "cpu";
              interval = 1;
              format = " $icon $utilization ";
            }
            {
              block = "sound";
              theme_overrides = { idle_bg = "#00223f"; };
              click = [{
                button = "left";
                cmd = "pavucontrol";
              }];
            }
            {
              block = "battery";
              device = "BAT0";
              format = " $icon $percentage $time $power ";
            }
            {
              block = "net";
              format = " $icon $ssid ";
              interval = 2;
              theme_overrides = { idle_bg = "#00223f"; };
              click = [{
                button = "left";
                cmd = "${pkgs.networkmanager}/bin/nmtui";
              }];

            }
            {
              block = "time";
              interval = 1;
              format = " $timestamp.datetime(f:'%F %T') ";
            }
          ];
          theme = "space-villain";
          icons = "none";
        };
      };
    };
  };
}
