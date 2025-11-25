{
  inputs,
  pkgs,
  ...
}: {
  services.hyprpaper = {
    enable = true;
    package = inputs.hyprpaper.packages.${pkgs.stdenv.hostPlatform.system}.default;
    settings = {
      preload = ["$HOME/.wallpapers/wallpaper.png"];
      wallpaper = [", $HOME/.wallpapers/wallpaper.png"];
    };
  };
}
