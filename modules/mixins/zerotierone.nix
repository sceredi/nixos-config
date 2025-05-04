let
  zerotierHomeNetwork = builtins.getEnv "ZEROTIER_HOME_NETWORK";
in
{
  services.zerotierone = {
    enable = true;
    port = 9993;
    joinNetworks = [ zerotierHomeNetwork ];
  };
}
