{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ../mixins/mako.nix
    ../mixins/hyprland
    ../mixins/wlsunset.nix
  ];
  config = {
    services.dbus.packages = with pkgs; [dconf];
    programs = {
      dconf.enable = true;
      light.enable = true;

      hyprland = {
        enable = true;
        package = inputs.hyprland.packages."${pkgs.system}".hyprland;
      };
    };

    xdg = {
      portal = {
        enable = true;
        extraPortals = with pkgs; [
          xdg-desktop-portal-gtk
          # xdg-desktop-portal-hyprland
        ];
      };
    };

    services.xserver.displayManager.gdm = {
      enable = true;
      wayland = true;
    };
    home-manager.users.simone = {pkgs, ...}: {
      home.sessionVariables = {
        XDG_CURRENT_DESKTOP = "hyprland";
        XDG_SESSION_DESKTOP = "hyprland";
        XDG_SESSION_TYPE = "wayland";
      };
    };
  };
}
