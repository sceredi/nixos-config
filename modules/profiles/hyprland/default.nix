{
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.hyprland.nixosModules.default
    ../../mixins/mako.nix
    ../../mixins/hyprland
    ../../mixins/gammastep.nix
    ./binds.nix
    ./rules.nix
    ./settings.nix
    ./smartgaps.nix
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
        package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      };
    };

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
    # tell Electron/Chromium to run on Wayland
    environment.variables.NIXOS_OZONE_WL = "1";
  };
}
