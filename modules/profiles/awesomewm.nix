{ pkgs, ... }: {
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
        sddm = { enable = true; };
        defaultSession = "none+awesome";
      };
      windowManager.awesome = {
        enable = true;
        luaModules = with pkgs.luaPackages; [ luarocks luadbi-mysql ];
      };
    };
  };
}
