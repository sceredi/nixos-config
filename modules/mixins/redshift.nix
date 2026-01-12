{
  location = {
    latitude = 44.12;
    longitude = 12.15;
  };
  services.redshift = {
    enable = true;
    temperature = {
      day = 6500;
      night = 4000;
    };
  };
}
