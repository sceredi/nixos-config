{
  pkgs,
  ...
}:
{

  # packages for administration tasks
  environment = {
    systemPackages = with pkgs; [
      quickemu
      kompose
      kubectl
      kubernetes-helm
    ];
  };

  services.k3s = {
    enable = true;
    role = "server";
    extraFlags = "--write-kubeconfig-mode 644"; # So you can run kubectl without sudo
  };
  environment.variables.KUBECONFIG = "/etc/rancher/k3s/k3s.yaml";
  virtualisation.libvirtd = {
    allowedBridges = [
      "nm-bridge"
      "virbr0"
    ];
    enable = true;
    qemu.runAsRoot = false;
  };
}
