{
  # Stuff i need for university and don't have time/want to put in the right spot
  # services.onedrive.enable = true;
  home-manager.users.simone = { pkgs, ... }: {
    home.packages = with pkgs; [
      chromium
      brave
      teams-for-linux
      # obsidian
      libsForQt5.okular
      # postman
      bruno # alternative to postman
      mongodb-compass
      # learning new languages
      exercism

      # lcmc
      jflap
    ];
  };
}
