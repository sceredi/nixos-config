{
  config = {
    home-manager.users.simone = { pkgs, ... }: {
      services.wlsunset = {
        enable = true;
        latitude = "44.1267537";
        longitude = "12.1504279";
        temperature.day = 6500;
        temperature.night = 4500;
      };
    };
  };
}
