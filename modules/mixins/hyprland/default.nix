{
  imports = [
    ../waybar.nix
  ];
  config = {
    home-manager.users.simone = {pkgs, ...}: {
      imports = [
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
      };
    };
  };
}
