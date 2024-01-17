{ config, inputs, ... }:
{
  nix.settings.trusted-users = [ "simone" ];
  users.users.simone = {
    isNormalUser = true;
    extraGroups = [
      "input"
      "lp"
      "wheel"
      "dialout"
    ];
  };
}

