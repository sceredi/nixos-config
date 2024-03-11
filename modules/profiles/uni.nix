{
  # Stuff i need for university and don't have time/want to put in the right spot
  services.onedrive.enable = true;
  # Remove once obsidian decides update its elecron version
  nixpkgs.config.permittedInsecurePackages =
    [ "electron-25.9.0" "freeimage-unstable-2021-11-01" ];
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
      rustdesk
      # learning new languages
      exercism
    ];
  };
}
