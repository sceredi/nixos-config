{
  location = {
    latitude = 44.12;
    longitude = 12.15;
  };
  services.redshift = {
    enable = true;
    temperature = {
      day = 4000;
      night = 4000;
    };
  };
}
