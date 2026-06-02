{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
      kind
      kubectl
      kubernetes-helm
  ];
}
