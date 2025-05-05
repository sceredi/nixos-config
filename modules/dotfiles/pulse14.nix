{
  home-manager.users.simone = {
    config,
    pkgs,
    ...
  }: {
    home = {
      file = {
        "${config.home.homeDirectory}/.config" = {
          source = ./xdg-config;
          recursive = true;
        };
        ".ideavimrc" = {
          source = ./xdg-home/.ideavimrc;
        };
        ".wallpapers" = {
          source = ./wallpapers;
          recursive = true;
        };
      };
    };
  };
}
