{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # virt-manager
    # virtualbox
    # distrobox
    quickemu
    quickgui
  ];
  # services = { 
  #   spice-vdagentd.enable = true;
  #   spice-webdavd.enable = true;
  #   qemuGuest.enable = true;
  # };
  virtualisation.libvirtd = {
    allowedBridges = [ "nm-bridge" "virbr0" ];
    enable = true;
    qemu.runAsRoot = false;
  };
  # boot.extraModulePackages = with config.boot.kernelPackages; [ virtualbox ];
}
