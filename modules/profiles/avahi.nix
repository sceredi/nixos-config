{
  services.avahi = {
    openFirewall = true;
    nssmdns4 = true; # Allows software to use Avahi to resolve.
    enable = true;
    publish = {
      enable = true;
      addresses = true;
      workstation = true;
      userServices = true;
    };
  };
}
