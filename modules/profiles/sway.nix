{
  inputs,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ../mixins/mako.nix
    ../mixins/sway.nix
    ../mixins/gammastep.nix
  ];
  config = {
    services = {
      dbus.packages = with pkgs; [ dconf ];

      # The NixOS option 'programs.sway.enable' is needed to make swaylock work,
      # since home-manager can't set PAM up to allow unlocks, along with some
      # other quirks.
      #   displayManager.defaultSession = "sway";
      #   displayManager.gdm = {
      #     enable = true;
      #     settings = {
      #       greeter = {
      #         include = "simone";
      #       };
      #     };
      #   };
      # };
      greetd = {
        enable = true;
        settings = {
          default_session = {
            command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --cmd sway";
            user = "simone";
          };
        };
      };
    };

    # Suppress the login tty from polluting the greeter
    systemd.services.greetd.serviceConfig = {
      Type = "idle";
      StandardInput = "tty";
      StandardOutput = "tty";
      StandardError = "journal";
      TTYReset = true;
      TTYVHangup = true;
      TTYVTDisallocate = true;
    };
    programs = {
      dconf.enable = true;
      sway = {
        enable = true;
        wrapperFeatures.gtk = true;
      };
    };

    xdg = {
      portal = {
        enable = true;
        wlr.enable = true;
        # extraPortals = [
        #   pkgs.xdg-desktop-portal-gtk
        # ];
      };
    };

    fonts.packages = with pkgs; [
      terminus_font_ttf
      font-awesome
    ];
    home-manager.users.simone =
      { pkgs, ... }:
      {
        # Block auto-sway reload, Sway crashes if allowed to reload this way.
        xdg.configFile."sway/config".onChange = lib.mkForce "";

        home.sessionVariables = {
          "SDL_VIDEODRIVER" = "wayland";
          "QT_QPA_PLATFORM" = "wayland";
          "QT_WAYLAND_DISABLE_WINDOWDECORATION" = "1";
          "_JAVA_AWT_WM_NONREPARENTING" = "1";
          "MOZ_ENABLE_WAYLAND" = "1";
        };

        home.packages = with pkgs; [
          wl-clipboard
          imv
        ];
      };
  };
}
