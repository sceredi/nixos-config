{
  config,
  inputs,
  ...
}: {
  nix.settings.trusted-users = ["simone"];
  users.users = {
    root.isNormalUser = false;
    simone = {
      isNormalUser = true;
      description = "SimoneCeredi";
      extraGroups = [
        "input"
        "lp"
        "wheel"
        "dialout"
        "networkmanager"
        "plugdev"
      ];
    };
  };
}
