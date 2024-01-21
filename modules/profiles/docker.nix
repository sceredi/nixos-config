{ config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [ docker docker-compose ];
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    autoPrune.enable = true;
  };
  users.users.simone.extraGroups = [ "docker" ];
}
