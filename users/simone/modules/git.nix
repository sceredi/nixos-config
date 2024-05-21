{ pkgs, ... }:

{
  home.packages = [ pkgs.git ];
  programs.git = {
    enable = true;
    userName = "sceredi";
    userEmail = "ceredi.simone.iti@gmail.com";
    signing = {
      key = "3F2E5DD6B8564CAAEFB75B214F363989CBECC6BC";
      signByDefault = true;
    };
    extraConfig = {
      init.defaultBranch = "master";
      pull.rebase = true;
      commit.gpgsign = true;
    };
  };
}
