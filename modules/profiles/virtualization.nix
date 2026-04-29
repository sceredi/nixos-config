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
      kubernetes
      minikube
      kubernetes-helm
    ];
  };

  services.k3s = {
    enable = true;
    role = "server";
    extraFlags = "--write-kubeconfig-mode 644"; # So you can run kubectl without sudo
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
