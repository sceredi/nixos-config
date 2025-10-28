{lib, ...}: {
  imports = [
    ../waybar.nix
  ];
  config = {
    home-manager.users.simone = {pkgs, ...}: {
      imports = [
        ./binds.nix
        ./settings.nix
        ./rules.nix
        ./smartgaps.nix
        ./gtk.nix
        ./hyprlock.nix
        ./wlogout.nix
        ./hyprpaper.nix
      ];
      config = {
        home.packages = with pkgs; [
          # screenshot
          grim
          slurp

          # utils
          wl-clipboard
          # wl-screenrec
          wlr-randr
        ];
        wayland.windowManager.hyprland = {
          enable = true;
          settings = {};
        };
      };
    };
  };
}
