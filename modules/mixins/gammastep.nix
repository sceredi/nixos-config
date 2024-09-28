{
  home-manager.users.simone = { ... }: {
    services.gammastep = {
      enable = true;
      latitude = 44.12;
      longitude = 12.15;
      temperature = {
        day = 3000;
        night = 2500;
      };
    };
  };
}
