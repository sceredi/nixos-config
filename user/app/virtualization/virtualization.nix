{ config, lib, pkgs, ... }:

{
    home.packages = with pkgs; [
      libvirt
      virt-manager
      qemu
      uefi-run
      lxc
      swtpm
      bottles

      dosfstools
    ];
}
