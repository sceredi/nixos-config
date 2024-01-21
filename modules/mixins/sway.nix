{ config, pkgs, input, ... }:
let
  modifier = "Mod4";
  left = "h";
  down = "j";
  up = "k";
  right = "l";
  terminal = "${pkgs.foot}/bin/foot";
  light = "${pkgs.light}/bin/light";
  rofi = "${pkgs.rofi}/bin/rofi -show drun";
  launcher = rofi;
  pamixer = "${pkgs.pamixer}/bin/pamixer";
  swaylockcmd =
    "${pkgs.swaylock}/bin/swaylock -i $HOME/.wallpapers/wallpaper.png";
  idlecmd = pkgs.writeShellScript "swayidle.sh" ''
    ${pkgs.swayidle}/bin/swayidle \
    before-sleep "${swaylockcmd}" \
    lock "${swaylockcmd}" \
    timeout 300 "${swaylockcmd}" \
    timeout 600 "${pkgs.systemd}/bin/systemctl suspend"
  '';
in {
  imports = [ ./waybar.nix ./nm-applet.nix ];
  config = {
    home-manager.users.simone = { pkgs, ... }: {
      wayland.windowManager.sway = {
        enable = true;
        wrapperFeatures = {
          base = false;
          gtk = false;
        };
        xwayland = true;
        config = rec {
          inherit terminal;
          inherit modifier;
          bars = [{ command = "${pkgs.waybar}/bin/waybar"; }];
          focus.followMouse = "always";
          window = {
            border = 1;
            titlebar = false;
            commands = [
              # Disables sleep when there are fullscreen applications
              {
                criteria = { app_id = ".*"; };
                command = "inhibit_idle fullscreen";
              }
              {
                criteria = { class = ".*"; };
                command = "inhibit_idle fullscreen";
              }
            ];
          };
          colors.focused = {
            background = "#4c7899";
            border = "#4c7899";
            childBorder = "#4c7899";
            indicator = "#2e9ef4";
            text = "#ffffff";
          };
          input = {
            "type:touchpad" = {
              tap = "enabled";
              natural_scroll = "enabled";
            };
            "5824:10203:Glove80_Keyboard" = { xkb_layout = "rpq"; };
            "1:1:AT_Translated_Set_2_keyboard" = {
              xkb_layout = "bus";
              xkb_options = "caps:escape";
            };
          };
          output = { "*" = { bg = "$HOME/.wallpapers/wallpaper.png fill"; }; };
          startup = [
            {
              always = true;
              command = "${pkgs.systemd}/bin/systemd-notify --ready || true";
            }
            {
              always = true;
              command = "${pkgs.mako}/bin/mako --default-timeout 3000";
            }
            {
              command = "exec ${idlecmd}";
              always = true;
            }
          ];
          keybindings = {
            "XF86MonBrightnessUp" =
              "exec ${light} -A 5 && ${light} -G | cut -d'.' -f1 > $SWAYSOCK.wob";
            "XF86MonBrightnessDown" =
              "exec ${light} -U 5 && ${light} -G | cut -d'.' -f1 > $SWAYSOCK.wob";
            "XF86AudioRaiseVolume" =
              "exec ${pamixer} -ui 2 && ${pamixer} --get-volume > $SWAYSOCK.wob";
            "XF86AudioLowerVolume" =
              "exec ${pamixer} -ud 2 && ${pamixer} --get-volume > $SWAYSOCK.wob";
            "XF86AudioMute" =
              "exec ${pamixer} --toggle-mute && ( ${pamixer} --get-mute && echo 0 > $SWAYSOCK.wob ) || ${pamixer} --get-volume > $SWAYSOCK.wob";

            "${modifier}+d" = "exec ${launcher}";
            "${modifier}+Return" = "exec ${terminal}";
            "${modifier}+Escape" = "exec ${swaylockcmd}";
            "${modifier}+q" = "kill";
            "${modifier}+Shift+r" = "reload";
            "${modifier}+Shift+e" =
              "exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -b 'Yes, exit sway' 'swaymsg exit'";

            "${modifier}+${left}" = "focus left";
            "${modifier}+${down}" = "focus down";
            "${modifier}+${up}" = "focus up";
            "${modifier}+${right}" = "focus right";

            "${modifier}+Left" = "focus left";
            "${modifier}+Down" = "focus down";
            "${modifier}+Up" = "focus up";
            "${modifier}+Right" = "focus right";

            "${modifier}+Shift+${left}" = "move left";
            "${modifier}+Shift+${down}" = "move down";
            "${modifier}+Shift+${up}" = "move up";
            "${modifier}+Shift+${right}" = "move right";

            "${modifier}+Shift+Left" = "move left";
            "${modifier}+Shift+Down" = "move down";
            "${modifier}+Shift+Up" = "move up";
            "${modifier}+Shift+Right" = "move right";

            # Switch to workspace
            # "${modifier}+0" = "workspace number 10";
            "${modifier}+1" = "workspace number 1";
            "${modifier}+2" = "workspace number 2";
            "${modifier}+3" = "workspace number 3";
            "${modifier}+4" = "workspace number 4";
            "${modifier}+5" = "workspace number 5";
            "${modifier}+6" = "workspace number 6";
            "${modifier}+7" = "workspace number 7";
            "${modifier}+8" = "workspace number 8";
            "${modifier}+9" = "workspace number 9";

            # "${modifier}+Shift+0" = "move container to workspace number 10";
            "${modifier}+Shift+1" = "move container to workspace number 1";
            "${modifier}+Shift+2" = "move container to workspace number 2";
            "${modifier}+Shift+3" = "move container to workspace number 3";
            "${modifier}+Shift+4" = "move container to workspace number 4";
            "${modifier}+Shift+5" = "move container to workspace number 5";
            "${modifier}+Shift+6" = "move container to workspace number 6";
            "${modifier}+Shift+7" = "move container to workspace number 7";
            "${modifier}+Shift+8" = "move container to workspace number 8";
            "${modifier}+Shift+9" = "move container to workspace number 9";

            # rpq stuff
            # "${modifier}+asterisk workspace" = "number 10";
            "${modifier}+plus" = "workspace number 1";
            "${modifier}+bracketleft" = "workspace number 2";
            "${modifier}+braceleft" = "workspace number 3";
            "${modifier}+parenleft" = "workspace number 4";
            "${modifier}+ampersand" = "workspace number 5";
            "${modifier}+equal" = "workspace number 6";
            "${modifier}+parenright" = "workspace number 7";
            "${modifier}+braceright" = "workspace number 8";
            "${modifier}+bracketright" = "workspace number 9";

            # "${modifier}+Shift+asterisk" =
            # "move container to workspace number 10";
            "${modifier}+Shift+plus" = "move container to workspace number 1";
            "${modifier}+Shift+bracketleft" =
              "move container to workspace number 2";
            "${modifier}+Shift+braceleft" =
              "move container to workspace number 3";
            "${modifier}+Shift+parenleft" =
              "move container to workspace number 4";
            "${modifier}+Shift+ampersand" =
              "move container to workspace number 5";
            "${modifier}+Shift+equal" = "move container to workspace number 6";
            "${modifier}+Shift+parenright" =
              "move container to workspace number 7";
            "${modifier}+Shift+braceright" =
              "move container to workspace number 8";
            "${modifier}+Shift+bracketright move container" =
              "to workspace number 9";

            # moving workspaces between monitors
            "${modifier}+m" = "move workspace to output right";
            "${modifier}+Shift+m" = "move workspace to output left";

            "${modifier}+b" = "splith";
            "${modifier}+v" = "splitv";

            "${modifier}+s" = "layout stacking";
            "${modifier}+w" = "layout tabbed";
            "${modifier}+e" = "layout toggle split";

            "${modifier}+f" = "fullscreen";

            "${modifier}+Shift+space" = "floating toggle";

            "${modifier}+space" = "focus mode_toggle";

            "${modifier}+a" = "focus parent";

            "${modifier}+r" = ''mode "resize"'';
          };
        };
      };
    };
  };
}
