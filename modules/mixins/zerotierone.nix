{
  services.zerotierone = {
    enable = true;
    port = 9993;
  };
  imports = [ ./private-zerotierone.nix ];
}
