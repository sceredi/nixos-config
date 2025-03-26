{
  services = {
    syncthing = {
      enable = true;
      user = "simone";
      dataDir = "/home/simone/notes"; # Default folder for new synced folders
      configDir = "/home/simone/.config/syncthing"; # Folder for Syncthing's settings and keys
    };
  };
}
