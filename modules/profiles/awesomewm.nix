{
  lib,
  pkgs,
  ...
}: {
  imports = [../mixins/awesomewm.nix];
  config = {
    services = {
      dbus.packages = with pkgs; [dconf];
      libinput = {
        enable = true;
        touchpad = {
          naturalScrolling = true;
        };
      };
      displayManager = {
        gdm = {
          enable = true;
        };
        defaultSession = lib.mkForce "none+awesome";
      };
      windowManager.awesome = {
        enable = true;
        luaModules = with pkgs.luaPackages; [
          luarocks
          luadbi-mysql
        ];
      };
      xserver = {
        enable = true;
      };
    };
    programs.dconf.enable = true;
    xdg = {
      portal = {
        enable = true;
        extraPortals = with pkgs; [xdg-desktop-portal-gtk];
      };
    };
  };
}
