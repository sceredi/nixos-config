{
  description = "My flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:nixos/nixos-hardware";
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
  };

  outputs =
    { self
    , nixpkgs
    , nixos-hardware
    , home-manager
    , utils
    , nix-flatpak
    , neovim-nightly-overlay
    , ...
    }@inputs: {
      nixosModules = import ./modules { lib = nixpkgs.lib; };
      nixosConfigurations = {
        pulse14 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/pulse14/configuration.nix
            utils.nixosModules.autoGenFromInputs
            home-manager.nixosModules.home-manager
            nixos-hardware.nixosModules.common-cpu-amd
            nixos-hardware.nixosModules.common-gpu-amd
            nixos-hardware.nixosModules.common-pc-laptop-ssd
            nix-flatpak.nixosModules.nix-flatpak
          ];
          specialArgs = { inherit inputs; };
        };
      };
    };
}
