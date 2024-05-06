{
  home-manager.users.simone = { pkgs, ... }:
    let
      python = pkgs.python3;
      pythonPackages = python.pkgs;
    in { home.packages = [ python ] ++ (with pythonPackages; [ pip ]); };
}
