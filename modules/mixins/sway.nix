{ config, pkgs, input, ... }:
let
  modifier = "Mod4";
  left = "h";
  down = "j";
  up = "k";
  right = "l";
  terminal = "${pkgs.wezterm}/bin/wezterm";
  light = "${pkgs.light}/bin/light";
  dmenu =
    "${pkgs.dmenu-rs}/bin/dmenu_run -p execute: -b -fn 'Terminus 9' -sf '#FFFFFF' -nf '#FFFFFF' -nb '#000000'";
  launcher = dmenu;
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
  dropdownTerminalCmd = pkgs.writeShellScript "launchkitty.sh" ''
    open=$(ps aux | grep -i "kitty --class=dropdown" | grep -v grep)
    if [[ $open -eq 0 ]]
    then
      ${pkgs.kitty}/bin/kitty --class=dropdown --detach
      until swaymsg scratchpad show
      do
        echo "Waiting for Kitty to appear..."
      done
    else
      echo "Kitty is already open"
      swaymsg "[app_id=dropdown] scratchpad show"
    fi
  '';
in
{
  imports = [ ./i3status.nix ];
  config = {
    home-manager.users.simone = { pkgs, ... }: {
      wayland.windowManager.sway = {
        enable = true;
        wrapperFeatures = {
          base = true;
          gtk = true;
        };
        xwayland = true;
        extraConfig = ''
          set $Locker ${swaylockcmd}
          set $mode_system System (l) lock, (e) logout, (s) suspend, (Shift+r) reboot, (Shift+s) shutdown
          mode "$mode_system" {
              bindsym l exec --no-startup-id $Locker, mode "default"
              bindsym e exec --no-startup-id swaymsg exit, mode "default"
              bindsym s exec systemctl suspend, mode "default"
              bindsym Shift+r exec --no-startup-id systemctl reboot, mode "default"
              bindsym Shift+s exec --no-startup-id systemctl poweroff -i, mode "default"

              # back to normal: Enter or Escape
              bindsym Return mode "default"
              bindsym Escape mode "default"
          }
        '';
        config = rec {
          inherit terminal;
          inherit modifier;
          bars = [{
            fonts = {
              names = [ "Terminus" ];
              size = 14.0;
            };
            statusCommand =
              "i3status-rs $HOME/.config/i3status-rust/config-top.toml";
            extraConfig = "height 20";
          }];
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

              # For dropdown terminal
              {
                criteria = { app_id = "dropdown"; };
                command = "floating enable";
              }
              {
                criteria = { app_id = "dropdown"; };
                command = "resize set 1920 1440";
              }
              {
                criteria = { app_id = "dropdown"; };
                command = "move scratchpad";
              }
              {
                criteria = { app_id = "dropdown"; };
                command = "border pixel 1";
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
            {
              always = true;
              command =
                "touch $SWAYSOCK.wob && tail -n0 -f $SWAYSOCK.wob | ${pkgs.wob}/bin/wob";
            }

            {
              always = true;
              command = "${pkgs.blueman}/bin/blueman-applet &";
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
            "${modifier}+Escape" = ''mode "$mode_system"'';
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

            "${modifier}+p" = "focus parent";

            "${modifier}+r" = ''mode "resize"'';

            "${modifier}+c" = "exec ${dropdownTerminalCmd}";

          };
        };
      };
    };
  };
}
