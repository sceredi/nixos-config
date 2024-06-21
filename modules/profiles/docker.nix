{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ docker docker-compose ];
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    autoPrune.enable = true;
    liveRestore = false;
  };
  users.users.simone.extraGroups = [ "docker" ];
}
