{pkgs, ...}: {
  services.pcscd.enable = true;
  programs.gnupg.agent = {
    enable = true;
    pinentryFlavor = "curses";
    pinentryPackage = pkgs.pinentry-all;
    enableSSHSupport = true;
  };
}
