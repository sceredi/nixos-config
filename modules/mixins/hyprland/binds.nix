{pkgs, ...}: let
  terminal = "${pkgs.alacritty}/bin/alacritty";
  pamixer = "${pkgs.pamixer}/bin/pamixer";
  light = "${pkgs.light}/bin/light";
  fuzzel = "${pkgs.fuzzel}/bin/fuzzel -I -w 50 -b 282a36fa -s 3d4474fa -C fffffffa";
  launcher = fuzzel;
  # swaylockcmd = "${pkgs.swaylock}/bin/swaylock -i $HOME/.wallpapers/wallpaper.png";
  screenshotarea = "hyprctl keyword animation 'fadeOut,0,0,default'; grimblast --notify copysave area; hyprctl keyword animation 'fadeOut,1,4,default'";
  dropdownTerminalCmd = pkgs.writeShellScript "launchwezterm.sh" ''
    hyprctl dispatch togglespecialworkspace dropdown
  '';
  workspaces = builtins.concatLists (
    builtins.genList (
      x: let
        ws = let
          c = (x + 1) / 10;
        in
          builtins.toString (x + 1 - (c * 10));
      in [
        "$mod, ${ws}, workspace, ${toString (x + 1)}"
        "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
      ]
    )
    10
  );
  toggle = program: let
    prog = builtins.substring 0 14 program;
  in "pkill ${prog} || uwsm app -- ${program}";

  runOnce = program: "pgrep ${program} || uwsm app -- ${program}";
in {
  home.packages = with pkgs; [
    grimblast
    wlogout
    gnome-control-center
  ];
  home.sessionVariables = {
    TERMINAL = "alacritty";
  };
  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";
    # mouse movements
    bindm = [
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
      "$mod ALT, mouse:272, resizewindow"
    ];
    bind = let
      monocle = "dwindle:no_gaps_when_only";
    in
      [
        # compositor commands
        "$mod SHIFT, W, exec, killall waybar;waybar"
        "$mod SHIFT, E, exec, pkill Hyprland"
        "$mod, Q, killactive,"
        "$mod, F, fullscreen,"
        "$mod, W, togglegroup,"
        "$mod SHIFT, N, changegroupactive, f"
        "$mod SHIFT, P, changegroupactive, b"
        "$mod, R, togglesplit,"
        "$mod, T, togglefloating,"
        "$mod, P, pseudo,"
        "$mod ALT, ,resizeactive,"
        "$mod, C, exec, ${dropdownTerminalCmd}"

        # toggle "monocle" (no_gaps_when_only)
        "$mod, M, exec, hyprctl keyword ${monocle} $(($(hyprctl getoption ${monocle} -j | jaq -r '.int') ^ 1))"

        # utility
        # terminal
        "$mod, Return, exec, uwsm app -- ${terminal}"
        # logout menu
        "$mod, Escape, exec, ${toggle "wlogout"} -p layer-shell"
        # lock screen
        # "$mod, L, exec, ${runOnce "hyprlock"}"

        "$mod, D, exec, ${toggle launcher}"

        # open settings
        "$mod, U, exec, XDG_CURRENT_DESKTOP=gnome ${runOnce "gnome-control-center"}"

        # move focus
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"
        "$mod, H, movefocus, l"
        "$mod, L, movefocus, r"
        "$mod, K, movefocus, u"
        "$mod, J, movefocus, d"

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

        # send focused workspace to left/right monitors
        "$mod SHIFT, G, movecurrentworkspacetomonitor, l"
        "$mod SHIFT, M, movecurrentworkspacetomonitor, r"
      ]
      ++ workspaces
      ++ [
        # rpq custom layout workspace bindings
        "$mod, plus, workspace, 1"
        "$mod, bracketleft, workspace, 2"
        "$mod, braceleft, workspace, 3"
        "$mod, parenleft, workspace, 4"
        "$mod, ampersand, workspace, 5"
        "$mod, equal, workspace, 6"
        "$mod, parenright, workspace, 7"
        "$mod, braceright, workspace, 8"
        "$mod, bracketright, workspace, 9"
        "$mod, asterisk, workspace, 10"

        "$mod SHIFT, plus, movetoworkspace, 1"
        "$mod SHIFT, bracketleft, movetoworkspace, 2"
        "$mod SHIFT, braceleft, movetoworkspace, 3"
        "$mod SHIFT, parenleft, movetoworkspace, 4"
        "$mod SHIFT, ampersand, movetoworkspace, 5"
        "$mod SHIFT, equal, movetoworkspace, 6"
        "$mod SHIFT, parenright, movetoworkspace, 7"
        "$mod SHIFT, braceright, movetoworkspace, 8"
        "$mod SHIFT, bracketright, movetoworkspace, 9"
        "$mod SHIFT, asterisk, movetoworkspace, 10"
      ];

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
