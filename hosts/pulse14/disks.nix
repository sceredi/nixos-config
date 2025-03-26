{
  pkgs,
  config,
  lib,
  ...
}:
{
  services.zfs.autoScrub.enable = true;
  networking.hostId = "a9c26e78";
  boot = {
    # Setup ZFS requirements
    supportedFilesystems = [ "zfs" ];
    # Since I'm using nixos-unstable mostly, the latest ZFS is sometimes
    # incompatible with the latest kernel.
    zfs.package = pkgs.zfs_unstable;
  };
}
