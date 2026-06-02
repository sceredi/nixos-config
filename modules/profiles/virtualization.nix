{
  pkgs,
  ...
}:
{

  # packages for administration tasks
  environment = {
    systemPackages = with pkgs; [
      quickemu
    ];
  };

  virtualisation.libvirtd = {
    allowedBridges = [
      "nm-bridge"
      "virbr0"
    ];
    enable = true;
    qemu.runAsRoot = false;
  };
}
