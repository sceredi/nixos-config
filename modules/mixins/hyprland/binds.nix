{ pkgs, ... }:
let
  terminal = "${pkgs.alacritty}/bin/alacritty";
  pamixer = "${pkgs.pamixer}/bin/pamixer";
  light = "${pkgs.light}/bin/light";
  fuzzel = "${pkgs.fuzzel}/bin/fuzzel";
  launcher = fuzzel;
  swaylockcmd =
    "${pkgs.swaylock}/bin/swaylock -i $HOME/.wallpapers/wallpaper.png";
  screenshotarea =
    "hyprctl keyword animation 'fadeOut,0,0,default'; grimblast --notify copysave area; hyprctl keyword animation 'fadeOut,1,4,default'";
  workspaces = builtins.concatLists (builtins.genList
    (x:
      let ws = let c = (x + 1) / 10; in builtins.toString (x + 1 - (c * 10));
      in [
        "$mod, ${ws}, workspace, ${toString (x + 1)}"
        "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
      ]) 10);
in
{
  home.packages = with pkgs; [ grimblast wlogout ];
  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";
    # mouse movements
    bindm = [
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
      "$mod ALT, mouse:272, resizewindow"
    ];
    bind =
      let monocle = "dwindle:no_gaps_when_only";
      in [
        # compositor commands
        "$mod SHIFT, W, exec, killall waybar;waybar"
        "$mod SHIFT, E, exec, pkill Hyprland"
        "$mod, Q, killactive,"
        "$mod, F, fullscreen,"
        # "$mod, G, togglegroup,"
        "$mod SHIFT, N, changegroupactive, f"
        "$mod SHIFT, P, changegroupactive, b"
        "$mod, R, togglesplit,"
        "$mod, T, togglefloating,"
        "$mod, P, pseudo,"
        "$mod ALT, ,resizeactive,"

        # toggle "monocle" (no_gaps_when_only)
        "$mod, M, exec, hyprctl keyword ${monocle} $(($(hyprctl getoption ${monocle} -j | jaq -r '.int') ^ 1))"

        # utility
        # terminal
        "$mod, Return, exec, ${terminal}"
        # logout menu
        "$mod, Escape, exec, wlogout"

        "$mod, D, exec, ${launcher}"

        # move focus
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"

        # screenshot
        # stop animations while screenshotting; makes black border go away
        ", Print, exec, ${screenshotarea}"
        "$mod SHIFT, R, exec, ${screenshotarea}"

        "CTRL, Print, exec, grimblast --notify --cursor copysave output"
        "$mod SHIFT CTRL, R, exec, grimblast --notify --cursor copysave output"

        "ALT, Print, exec, grimblast --notify --cursor copysave screen"
        "$mod SHIFT ALT, R, exec, grimblast --notify --cursor copysave screen"

        # special workspace
        "$mod SHIFT, grave, movetoworkspace, special"
        "$mod, grave, togglespecialworkspace, eDP-1"

        # cycle monitors
        "$mod, G, focusmonitor, l"
        "$mod, M, focusmonitor, r"

        # send focused workspace to left/right monitors
        "$mod SHIFT, G, movecurrentworkspacetomonitor, l"
        "$mod SHIFT, M, movecurrentworkspacetomonitor, r"
      ] ++ workspaces;

    bindl = [
      # media controls
      ", XF86AudioPlay, exec, playerctl play-pause"
      ", XF86AudioPrev, exec, playerctl previous"
      ", XF86AudioNext, exec, playerctl next"

      # volume
      ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
    ];

    bindle = [
      ", XF86AudioRaiseVolume, exec, ${pamixer} -i 5"
      ", XF86AudioLowerVolume, exec, ${pamixer} -d 5"
      ", XF86AudioMute, exec, ${pamixer} -t"
      ", XF86MonBrightnessUp, exec, ${light} -A 5"
      ", XF86MonBrightnessDown, exec, ${light} -U 5"
    ];
  };
}
