{ pkgs, ... }: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    package = pkgs.neovim-nightly;
  };
  home-manager.users.simone = { pkgs, ... }: {
    home.packages = with pkgs;
      [
        # black
        # isort

      ];
  };
}
