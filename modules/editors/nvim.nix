{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
  };
  home-manager.users.simone =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        tree-sitter
      ];
    };
}
