{
  home-manager.users.simone = {pkgs, ...}: let
    # myJkd = pkgs.jdk21;
    # idea-overriden = pkgs.jetbrains.idea-ultimate.override {
    #   jdk = myJkd;
    # };
    # pycharm-overriden = pkgs.jetbrains.pycharm-professional.override {
    #   jdk = myJkd;
    # };
  in {
    home.packages = with pkgs; [
      jetbrains-toolbox
      jetbrains.idea-ultimate
      jetbrains.pycharm-professional
    ];
    # ++ [
    #   idea-overriden
    #   pycharm-overriden
    # ];
  };
}
