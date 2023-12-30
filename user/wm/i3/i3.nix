{ config, lib, pkgs, font, ... }:
let 
  mod = "Mod4";
in {

  imports = [
    ../../cursor/quintom.nix
  ];

  home.packages = with pkgs; [
    dmenu-rs #application launcher most people use
    i3status # gives you the default i3 status bar
    i3lock #default i3 screen locker
    i3blocks #if you are planning on using i3blocks over i3status
    arandr
  ];

  xsession.windowManager.i3 = {
    enable = true;
    config = {
      modifier = mod;

      fonts = ["JetBrains Mono 13"];

      keybindings = lib.mkOptionDefault {
        "${mod}+p" = "exec ${pkgs.dmenu-rs}/bin/dmenu-rs";
        "${mod}+x" = "exec sh -c '${pkgs.maim}/bin/maim -s | xclip -selection clipboard -t image/png'";
        "${mod}+Escape" = "exec sh -c '${pkgs.i3lock}/bin/i3lock -c 222222 & sleep 5 && xset dpms force of'";

        # Focus
        "${mod}+h" = "focus left";
        "${mod}+j" = "focus down";
        "${mod}+k" = "focus up";
        "${mod}+l" = "focus right";

        # Move
        "${mod}+Shift+h" = "move left";
        "${mod}+Shift+j" = "move down";
        "${mod}+Shift+k" = "move up";
        "${mod}+Shift+l" = "move right";

        # My multi monitor setup
        "${mod}+m" = "move workspace to output DP-2";
        "${mod}+Shift+m" = "move workspace to output DP-5";

        # kill app
        "${mod}+q" = "kill";
      };

      bars = [
        {
          position = "bottom";
          statusCommand = "${pkgs.i3status}/bin/i3status";
        }
      ];
    };
  };

}
