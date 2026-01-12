{
  config = {
    home-manager.users.simone = {pkgs, ...}: {
      services.wlsunset = {
        enable = true;
        sunrise = "06.30";
        sunset = "18:00";
        temperature.day = 6500;
        temperature.night = 3000;
      };
    };
  };
}
