{ config, pkgs, ... }:

{
  # import X11 config
  imports = [ ./x11.nix
              ./pipewire.nix
              ./dbus.nix
            ];
  services.xserver = {
    displayManager = {
      defaultSession = "plasma";
    };
  };
}
