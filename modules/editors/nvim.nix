{
  home-manager.users.simone = { pkgs, ... }: {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      vimAlias = true;
      viAlias = true;
    };

    # xdg.configFile.nvim = {
    #   source = ./config;
    #   recursive = true;
    # };
  };
}
