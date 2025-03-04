{
  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      persistent = true;
      options = "--delete-older-than 30d";
    };
    settings.auto-optimise-store = true;
  };
}
