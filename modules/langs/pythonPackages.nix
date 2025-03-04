{
  home-manager.users.simone = { pkgs, ... }:
    let
      python = pkgs.python311;
      pythonPackages = python.pkgs;
    in {
      home.packages = [ python pkgs.pyright ] ++ (with pythonPackages; [ pip ]);
    };
}
