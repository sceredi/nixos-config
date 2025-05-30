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
    sceredi-nix-cats = {
      url = "github:sceredi/init.lua";
    };
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    emacs-overlay.inputs.nixpkgs.follows = "nixpkgs";
    alacritty-theme.url = "github:alexghr/alacritty-theme.nix";
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      # IMPORTANT: we're using "libgbm" and is only available in unstable so ensure
      # to have it up to date or simply don't specify the nixpkgs input
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixos-hardware,
    home-manager,
    firefox-addons,
    utils,
    nix-flatpak,
    alacritty-theme,
    sceredi-nix-cats,
    zen-browser,
    ...
  } @ inputs: {
    nixosModules = import ./modules {inherit (nixpkgs) lib;};
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
            {
              config,
              pkgs,
              ...
            }: {
              # install the overlay
              nixpkgs.overlays = [alacritty-theme.overlays.default];
            }
          )
          (
            {
              config,
              pkgs,
              ...
            }: {
              home-manager.users.simone = hm: {
                programs.alacritty = {
                  enable = true;
                  # use a color scheme from the overlay
                  settings.general.import = [pkgs.alacritty-theme.rose_pine_moon];
                };
              };
            }
          )
        ];
        specialArgs = {inherit inputs;};
      };
    };
  };
}
