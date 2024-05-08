{
  imports = [ ./private-zerotierone.nix ];
  services.zerotierone = {
    enable = true;
    port = 9993;
  };
}
