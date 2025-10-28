{
  inputs,
  pkgs,
  ...
}: {
  services.hyprpaper = {
    enable = true;
    package = inputs.hyprpaper.packages.${pkgs.system}.default;
    settings = {
      preload = ["$HOME/.wallpapers/wallpaper.png"];
      wallpaper = [", $HOME/.wallpapers/wallpaper.png"];
    };
  };
}
