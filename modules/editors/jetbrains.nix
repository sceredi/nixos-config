{
  home-manager.users.simone = {pkgs, ...}: {
    home.packages = with pkgs; [
      jetbrains-toolbox
      jetbrains.idea-ultimate
      jetbrains.pycharm-professional
    ];
  };
}
