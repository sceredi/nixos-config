{ pkgs, ... }: {
  services.pcscd.enable = true;
  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-gtk2;
    enableSSHSupport = true;
  };
  programs.ssh = {
    startAgent = true;
    askPassword = "${pkgs.kdePackages.ksshaskpass}/bin/ksshaskpass";
    extraConfig = ''
      AddKeysToAgent yes
    '';
  };
}
