{pkgs, ...}: {
  imports = [../mixins/i3.nix];
  config = {
    services = {
      dbus.packages = with pkgs; [dconf];
      libinput = {
        enable = true;
        touchpad = {
          naturalScrolling = true;
        };
      };
      xserver = {
        enable = true;
        displayManager = {
          gdm = {
            enable = true;
          };
          defaultSession = "none+i3";
        };
        windowManager.i3 = {
          enable = true;
        };
      };
    };
    programs.dconf.enable = true;
    programs.light.enable = true;
    xdg = {
      portal = {
        enable = true;
        extraPortals = with pkgs; [xdg-desktop-portal-gtk];
      };
    };
    home-manager.users.simone = {pkgs, ...}: {
      home.packages = with pkgs; [
        i3status-rust
        imv
        alacritty
        xclip
      ];
    };
  };
}
