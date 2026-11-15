{
  services.avahi = {
    openFirewall = true;
    nssmdns4 = true; # Allows software to use Avahi to resolve.
    enable = true;
    settings.publish = {
      publish-addresses = true;
      publish-workstation = true;
      disable-user-service-publishing = false;
    };
  };
}
