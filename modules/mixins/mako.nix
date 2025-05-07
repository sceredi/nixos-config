{
  config = {
    home-manager.users.simone = {pkgs, ...}: {
      services.mako = {
        enable = true;
        settings.font = "Terminus";
      };
    };
  };
}
