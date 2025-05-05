{
  config,
  lib,
  pkgs,
  ...
}: {
  environment.systemPackages = [
    (pkgs.waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ ["-Dexperimental=true"];
    }))
  ];
  home-manager.users.simone = {
    config,
    pkgs,
    ...
  }: {
    home.file = {
      "${config.home.homeDirectory}/.config/waybar" = {
        source = ./waybar;
        recursive = true;
      };
    };
  };
}
