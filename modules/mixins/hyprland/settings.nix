{pkgs, ...}: {
  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";
    env = ["QT_WAYLAND_DISABLE_WINDOWDECORATION,1"];

    exec-once = [
      # finalize startup
      "uwsm finalize"
      "${pkgs.systemd}/bin/systemd-notify --ready || true"
      "${pkgs.mako}/bin/mako --default-timeout 3000"
      "waybar"
      "${pkgs.wezterm}/bin/wezterm start --class dropdown"
    ];

    general = {
      gaps_in = 5;
      gaps_out = 5;
      border_size = 1;
      "col.active_border" = "rgba(88888888)";
      "col.inactive_border" = "rgba(00000088)";

      allow_tearing = true;
      resize_on_border = true;
    };

    decoration = {
      rounding = 10;
      rounding_power = 3;
      blur = {
        enabled = true;
        brightness = 1.0;
        contrast = 1.0;
        noise = 0.01;

        vibrancy = 0.2;
        vibrancy_darkness = 0.5;

        passes = 4;
        size = 7;

        popups = true;
        popups_ignorealpha = 0.2;
      };

      shadow = {
        enabled = true;
        color = "rgba(00000055)";
        ignore_window = true;
        offset = "0 15";
        range = 100;
        render_power = 2;
        scale = 0.97;
      };
    };

    animations = {
      enabled = true;
      animation = [
        "border, 1, 2, default"
        "fade, 1, 4, default"
        "windows, 1, 3, default, popin 80%"
        "workspaces, 1, 2, default, slide"
      ];
    };

    group = {
      groupbar = {
        font_size = 10;
        gradients = false;
        text_color = "rgb(b6c4ff)";
      };

      "col.border_active" = "rgba(35447988)";
      "col.border_inactive" = "rgba(dce1ff88)";
    };

    input = {
      kb_layout = "bus,rpq";
      kb_options = "caps:escape";

      # focus change on cursor move
      follow_mouse = 1;
      accel_profile = "flat";
      touchpad.scroll_factor = 0.1;
      touchpad.natural_scroll = true;
    };
    device = [
      {
        name = "at-translated-set-2-keyboard";
        kb_layout = "bus";
        kb_options = "caps:escape";
      }
      {
        name = "glove80-keyboard";
        kb_layout = "rpq";
      }
      {
        name = "moergo-glove80-left-keyboard";
        kb_layout = "rpq";
      }
    ];

    dwindle = {
      # keep floating dimentions while tiling
      pseudotile = true;
      preserve_split = true;
    };

    misc = {
      # disable auto polling for config file changes
      disable_autoreload = true;

      force_default_wallpaper = 0;

      # disable dragging animation
      animate_mouse_windowdragging = false;

      # enable variable refresh rate (effective depending on hardware)
      vrr = 1;
    };

    render = {
      direct_scanout = true;
      # Fixes some apps stuttering (xournalpp, hyprlock). Possibly an amdgpu bug
      # explicit_sync = 0;
      # explicit_sync_kms = 0;
    };

    xwayland.force_zero_scaling = true;

    debug.disable_logs = false;

    plugin = {
      hyprbars = {
        bar_height = 24;
        bar_precedence_over_border = true;

        # order is right-to-left
        hyprbars-button = [
          # close
          "rgb(ffb4ab), 15, , hyprctl dispatch killactive"
          # maximize
          "rgb(b6c4ff), 15, , hyprctl dispatch fullscreen 1"
        ];
      };

      hyprexpo = {
        columns = 3;
        gap_size = 4;
        bg_col = "rgb(000000)";

        enable_gesture = true;
        gesture_distance = 300;
        gesture_positive = false;
      };
    };
  };
}
