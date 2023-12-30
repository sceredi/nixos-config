{ config, lib, pkgs, name, email, ... }:

{
  home.packages = [ pkgs.git ];
  programs.git = {
    enable = true;
    userName = "Simone Ceredi";
    userEmail = email;
    extraConfig = {
      init.defaultBranch = "master";
    };
  };
}
