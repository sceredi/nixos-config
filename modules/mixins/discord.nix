{
  home-manager.users.simone =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [ discord ];
    };
}
