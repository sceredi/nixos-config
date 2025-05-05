{pkgs, ...}: let
  swaylockcmd = "${pkgs.swaylock}/bin/swaylock -i $HOME/.wallpapers/wallpaper.png";
  idlecmd = pkgs.writeShellScript "swayidle.sh" ''
    ${pkgs.swayidle}/bin/swayidle \
    before-sleep "${swaylockcmd}" \
    lock "${swaylockcmd}" \
    timeout 300 "${swaylockcmd}" \
    timeout 600 "${pkgs.systemd}/bin/systemctl suspend"
  '';
  waybar = "${pkgs.waybar}/bin/waybar";
in {
  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";
    env = ["QT_WAYLAND_DISABLE_WINDOWDECORATION,1"];

    exec-once = [
      "${pkgs.systemd}/bin/systemd-notify --ready || true"
      "${pkgs.mako}/bin/mako --default-timeout 3000"
      "exec ${idlecmd}"
      "exec i3status-rs $HOME/.config/i3status-rust/config-top.toml"
    ];

    general = {
      gaps_in = 0;
      gaps_out = 0;
      border_size = 1;
      "col.active_border" = "rgba(88888888)";
      "col.inactive_border" = "rgba(00000088)";

      allow_tearing = false;
      resize_on_border = true;
    };

    decoration = {
      rounding = 0;
      blur = {
        enabled = false;
        brightness = 1.0;
        contrast = 1.0;
        noise = 2.0e-2;

        passes = 3;
        size = 10;
      };

      drop_shadow = true;
      shadow_ignore_window = true;
      shadow_offset = "0 2";
      shadow_range = 20;
      shadow_render_power = 3;
      "col.shadow" = "rgba(00000055)";
    };

    animations = {
      enabled = false;
      animation = [
        "border, 1, 2, default"
        "fade, 1, 4, default"
        "windows, 1, 3, default, popin 80%"
        "workspaces, 1, 2, default, slide"
      ];
    };

    input = {
      kb_layout = "bus,rpq";

      # focus change on cursor move
      follow_mouse = 1;
      accel_profile = "flat";
      touchpad.scroll_factor = 0.1;
      touchpad.natural_scroll = true;
    };

    "device:glove80-keyboard" = {
      # set keyboard layout
      kb_layout = "rpq";
    };

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

      # we do, in fact, want direct scanout
      no_direct_scanout = false;
    };

    # touchpad gestures
    # gestures = {
    #   workspace_swipe = true;
    #   workspace_swipe_forever = true;
    # };

    # xwayland.force_zero_scaling = true;

    debug.disable_logs = false;
  };
}
