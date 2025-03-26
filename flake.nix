{
  description = "My flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:nixos/nixos-hardware/master";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    utils = {
      url = "github:gytis-ivaskevicius/flake-utils-plus";
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:sceredi/nixvim-flake";
    };
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    emacs-overlay.inputs.nixpkgs.follows = "nixpkgs";
    alacritty-theme.url = "github:alexghr/alacritty-theme.nix";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixos-hardware,
      home-manager,
      firefox-addons,
      utils,
      nix-flatpak,
      alacritty-theme,
      nixvim,
      ...
    }@inputs:
    {
      nixosModules = import ./modules { lib = nixpkgs.lib; };
      nixosConfigurations = {
        pulse14 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/pulse14/configuration.nix
            utils.nixosModules.autoGenFromInputs
            home-manager.nixosModules.home-manager
            nixos-hardware.nixosModules.tuxedo-pulse-14-gen3
            nix-flatpak.nixosModules.nix-flatpak
            (
              { config, pkgs, ... }:
              {
                # install the overlay
                nixpkgs.overlays = [ alacritty-theme.overlays.default ];
              }
            )
            (
              { config, pkgs, ... }:
              {
                home-manager.users.simone = hm: {
                  programs.alacritty = {
                    enable = true;
                    # use a color scheme from the overlay
                    settings.general.import = [ pkgs.alacritty-theme.rose_pine_moon ];
                  };
                };
              }
            )
          ];
          specialArgs = { inherit inputs; };
        };
      };
    };
}
