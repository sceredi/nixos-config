{
  home-manager.users.simone = _: {
    services.gammastep = {
      enable = true;
      dawnTime = "6:00-7:45";
      duskTime = "18:35-20:15";
      temperature = {
        day = 6500;
        night = 3000;
      };
    };
  };
}
