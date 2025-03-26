{
  home-manager.users.simone =
    { ... }:
    {
      services.gammastep = {
        enable = true;
        dawnTime = "6:00-7:45";
        duskTime = "18:35-20:15";
        temperature = {
          day = 3000;
          night = 2500;
        };
      };
    };
}
