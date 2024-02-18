{ lib, pkgs, ... }: {
  imports = [ ../mixins/awesomewm.nix ];
  config = {
    services.dbus.packages = with pkgs; [ dconf ];
    programs.dconf.enable = true;
    xdg = {
      portal = {
        enable = true;
        extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
      };
    };
    services.xserver = {
      enable = true;
      displayManager = {
        gdm = { enable = true; };
        defaultSession = lib.mkForce "none+awesome";
      };
      windowManager.awesome = {
        enable = true;
        luaModules = with pkgs.luaPackages; [
          luarocks
          luadbi-mysql
        ];
      };
      libinput = {
        enable = true;
        touchpad = { naturalScrolling = true; };
      };
    };
  };
}
