# My nixos-config
I have taken inspiration (copied for the most part) from [librephoenix](https://github.com/librephoenix/nixos-config)

## Installation
Clone the repo:
```
git clone https://github.com/SimoneCeredi/nixos-config.git ~/.dotfiles
```
Generate hardware-configuration:
```
cd ~/.dotfiles
sudo nixos-generate-config --show-hardware-config > system/hardware-configuration.nix
```
Set the username and everything you want to change inside the flake.nix file:
```
...
let
  ...
  # ----- USER SETTINGS ----- #
  username = "YOURUSERNAME"; # username
  name = "YOURNAME"; # name/identifier
...
```
After setting up the variables switch into the system configuration by running:
```
cd ~/.dotfiles
sudo nixos-rebuild switch --flake .#system
```
Now install home manager by:
```
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install
```
Sometimes it doesn't like to cooperate so just hit it with a:
```
nix-channel --add https://nixos.org/channels/nixpkgs-unstable
nix-channel --update
```
And now that home manager is running you can setup the home manager configuration by running:
```
cd ~/.dotfiles
home-manager switch --flake .#user
```
