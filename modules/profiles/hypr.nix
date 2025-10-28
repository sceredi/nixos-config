{
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
    services.dbus.packages = with pkgs; [dconf];
    programs = {
      dconf.enable = true;
      light.enable = true;

      hyprland = {
        enable = true;
        withUWSM = true;
        # package = inputs.hyprland.packages.${pkgs.system}.hyprland;
        # portalPackage = null;
      };
    };

    xdg = {
      portal = {
        enable = true;
        extraPortals = with pkgs; [
          xdg-desktop-portal-hyprland
        ];
      };
    };

    services.displayManager.gdm = {
      enable = true;
      wayland = true;
    };
    home-manager.users.simone = {pkgs, ...}: {
      home.sessionVariables = {
        XDG_CURRENT_DESKTOP = "hyprland";
        XDG_SESSION_DESKTOP = "hyprland";
        XDG_SESSION_TYPE = "wayland";
        QT_QPA_PLATFORM = "wayland";
        SDL_VIDEODRIVER = "wayland";
      };
    };
  };
}
