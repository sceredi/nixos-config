{
  description = "My flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:nixos/nixos-hardware/master";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    firefox = {
      url = "github:colemickens/flake-firefox-nightly";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    utils = { url = "github:gytis-ivaskevicius/flake-utils-plus"; };
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    nix-straight = {
      url =
        "github:codingkoi/nix-straight.el?ref=codingkoi/apply-librephoenixs-fix";
      flake = false;
    };
    nix-doom-emacs = {
      url = "github:nix-community/nix-doom-emacs";
      inputs = { nix-straight.follows = "nix-straight"; };
    };
  };

  outputs = { self, nixpkgs, nixos-hardware, home-manager, utils, nix-flatpak
    , neovim-nightly-overlay, nix-doom-emacs, ... }@inputs: {
      nixosModules = import ./modules { lib = nixpkgs.lib; };
      nixosConfigurations = {
        pulse14 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/pulse14/configuration.nix
            utils.nixosModules.autoGenFromInputs
            home-manager.nixosModules.home-manager
            nixos-hardware.nixosModules.tuxedo-pulse-14-gen3
            nixos-hardware.nixosModules.common-gpu-amd
            nix-flatpak.nixosModules.nix-flatpak
            {
              home-manager.users.simone = { ... }: {
                imports = [ nix-doom-emacs.hmModule ];
                programs.doom-emacs = {
                  enable = true;
                  doomPrivateDir = ./doom.d;
                };
              };
            }
          ];
          specialArgs = { inherit inputs; };
        };
      };
    };
}
