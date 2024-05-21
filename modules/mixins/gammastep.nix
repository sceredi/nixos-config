{
  home-manager.users.simone = { ... }: {
    services.gammastep = {
      enable = true;
      latitude = 44.12;
      longitude = 12.15;
      temperature = {
        day = 4000;
        night = 3000;
      };
    };
  };
}
