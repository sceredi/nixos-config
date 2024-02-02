{ config, pkgs, input, ... }:
let
  modifier = "Mod4";
  left = "h";
  down = "j";
  up = "k";
  right = "l";
  terminal = "${pkgs.alacritty}/bin/alacritty";
  brightnessctl = "${pkgs.brightnessctl}/bin/brightnessctl";
  dmenu =
    "${pkgs.dmenu-rs}/bin/dmenu_run -p execute: -b -fn 'Terminus 9' -sf '#FFFFFF' -nf '#FFFFFF' -nb '#000000'";
  launcher = dmenu;
  pactl = "${pkgs.pulseaudio}/bin/pactl";
  i3lockcmd = "${pkgs.i3lock}/bin/i3lock -c 2f3233";
in {
  imports = [ ./autorandr.nix ./i3status.nix ./redshift.nix ];
  config = {
    home-manager.users.simone = { pkgs, ... }: {
      xsession.windowManager.i3 = {
        enable = true;
        extraConfig = ''
          set $Locker ${i3lockcmd}
          set $mode_system System (l) lock, (e) logout, (s) suspend, (Shift+r) reboot, (Shift+s) shutdown
          mode "$mode_system" {
              bindsym l exec --no-startup-id $Locker, mode "default"
              bindsym e exec --no-startup-id i3-msg exit, mode "default"
              bindsym s exec --no-startup-id $Locker && systemctl suspend, mode "default"
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
          window = {
            border = 1;
            titlebar = false;
          };
          colors.focused = {
            background = "#4c7899";
            border = "#4c7899";
            childBorder = "#4c7899";
            indicator = "#2e9ef4";
            text = "#ffffff";
          };
          startup = [
            {
              always = true;
              command = "${pkgs.systemd}/bin/systemd-notify --ready || true";
            }
            {
              always = true;
              command = "${pkgs.dunst}/bin/dunst &";
            }
            {
              always = true;
              command = "${pkgs.networkmanagerapplet}/bin/nm-applet &";
            }
            {
              always = true;
              command = "${pkgs.blueman}/bin/blueman-applet &";
            }
          ];
          keybindings = {
            "XF86MonBrightnessUp" = "exec ${brightnessctl} set 5%+";
            "XF86MonBrightnessDown" = "exec ${brightnessctl} set 5%-";
            "XF86AudioRaiseVolume" = "exec ${pactl} set-sink-volume 0 +5%";
            "XF86AudioLowerVolume" = "exec ${pactl} set-sink-volume 0 -5%";
            "XF86AudioMute" = "exec ${pactl} set-sink-mute 0 toggle";

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
