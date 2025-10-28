{
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ../mixins/mako.nix
    ../mixins/hyprland
    ../mixins/gammastep.nix
  ];
  config = {
    services = {
      dbus.packages = with pkgs; [dconf];
      displayManager.defaultSession = lib.mkForce "hyprland-uwsm";
      displayManager.gdm = {
        enable = true;
        wayland = true;
        settings = {
          greeter = {
            include = "simone";
          };
        };
      };
    };
    programs = {
      dconf.enable = true;
      light.enable = true;

      hyprland = {
        enable = true;
        withUWSM = true;
        package = inputs.hyprland.packages.${pkgs.system}.hyprland;
      };
    };

    # xdg = {
    #   portal = {
    #     enable = true;
    #     extraPortals = with pkgs; [
    #       xdg-desktop-portal-hyprland
    #     ];
    #   };
    # };

    home-manager.users.simone = {pkgs, ...}: {
      home.sessionVariables = {
        XDG_CURRENT_DESKTOP = "hyprland";
        XDG_SESSION_DESKTOP = "hyprland";
        XDG_SESSION_TYPE = "wayland";
        QT_QPA_PLATFORM = "wayland";
        SDL_VIDEODRIVER = "wayland";
      };
      home.packages = with pkgs; [
        wl-clipboard
        imv
      ];
    };
  };
}
