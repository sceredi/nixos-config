{
  home-manager.users.simone = { config, pkgs, ... }: {
    home.packages = with pkgs; [ alacritty xorg.xbacklight ];
    home.file = {
      "${config.home.homeDirectory}/.config/awesome" = {
        source = ./awesomewm;
        recursive = true;
      };
    };
  };
}
