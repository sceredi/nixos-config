{
  config,
  pkgs,
  input,
  ...
}:
let
  modifier = "SUPER";
  left = "h";
  down = "j";
  up = "k";
  right = "l";
  terminal = "${pkgs.wezterm}/bin/wezterm";
  light = "${pkgs.light}/bin/light";
  rofi = "${pkgs.rofi}/bin/rofi -show drun";
  launcher = rofi;
  pamixer = "${pkgs.pamixer}/bin/pamixer";
  swaylockcmd = "${pkgs.swaylock}/bin/swaylock -i $HOME/.wallpapers/wallpaper.png";
  idlecmd = pkgs.writeShellScript "swayidle.sh" ''
    ${pkgs.swayidle}/bin/swayidle \
    before-sleep "${swaylockcmd}" \
    lock "${swaylockcmd}" \
    timeout 300 "${swaylockcmd}" \
    timeout 600 "${pkgs.systemd}/bin/systemctl suspend"
  '';
in
{
  imports = [
    ../i3status.nix
    ../nm-applet.nix
  ];
  config = {
    home-manager.users.simone =
      { pkgs, ... }:
      {
        imports = [
          ./binds.nix
          ./settings.nix
          ./rules.nix
        ];
        config = {
          wayland.windowManager.hyprland = {
            enable = true;
            settings = { };
          };
        };
      };
  };
}
