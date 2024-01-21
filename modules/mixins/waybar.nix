{
  home-manager.users.simone = { config, pkgs, ... }: {
    home.file = {
      "${config.home.homeDirectory}/.config/waybar" = {
        source = ./waybar;
        recursive = true;
      };
    };
  };
}
