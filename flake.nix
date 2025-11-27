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
    hyprland.url = "github:hyprwm/hyprland";
    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "hyprland/nixpkgs";
    };

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    hyprlock = {
      url = "github:hyprwm/hyprlock";
      inputs = {
        hyprgraphics.follows = "hyprland/hyprgraphics";
        hyprlang.follows = "hyprland/hyprlang";
        hyprutils.follows = "hyprland/hyprutils";
        nixpkgs.follows = "hyprland/nixpkgs";
        systems.follows = "hyprland/systems";
      };
    };
    hyprpaper = {
      url = "github:hyprwm/hyprpaper";
      inputs = {
        hyprgraphics.follows = "hyprland/hyprgraphics";
        hyprlang.follows = "hyprland/hyprlang";
        hyprutils.follows = "hyprland/hyprutils";
        nixpkgs.follows = "hyprland/nixpkgs";
        systems.follows = "hyprland/systems";
      };
    };
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
  };

  outputs = {
    nixpkgs,
    nixos-hardware,
    home-manager,
    utils,
    nix-flatpak,
    alacritty-theme,
    chaotic,
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
          {
            # install the overlay
            nixpkgs.overlays = [alacritty-theme.overlays.default];
          }
          (
            {pkgs, ...}: {
              home-manager.users.simone = hm: {
                programs.alacritty = {
                  enable = true;
                  # use a color scheme from the overlay
                  settings.general.import = [pkgs.alacritty-theme.gruvbox_dark];
                };
              };
            }
          )
        ];
        specialArgs = {inherit inputs;};
      };
      pavilion15 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/pavilion15/configuration.nix
          utils.nixosModules.autoGenFromInputs
          home-manager.nixosModules.home-manager
          nix-flatpak.nixosModules.nix-flatpak
          {
            # install the overlay
            nixpkgs.overlays = [alacritty-theme.overlays.default];
          }
          (
            {pkgs, ...}: {
              home-manager.users.simone = hm: {
                programs.alacritty = {
                  enable = true;
                  # use a color scheme from the overlay
                  settings.general.import = [pkgs.alacritty-theme.gruvbox_dark];
                };
              };
            }
          )
        ];
        specialArgs = {inherit inputs;};
      };
      reactor = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/reactor/configuration.nix
          utils.nixosModules.autoGenFromInputs
          home-manager.nixosModules.home-manager
          nix-flatpak.nixosModules.nix-flatpak
          nixos-hardware.nixosModules.common-gpu-nvidia-nonprime
          nixos-hardware.nixosModules.common-cpu-amd
          nixos-hardware.nixosModules.common-pc
          nixos-hardware.nixosModules.common-pc-ssd
          chaotic.nixosModules.default
          {
            # install the overlay
            nixpkgs.overlays = [alacritty-theme.overlays.default];
          }
          (
            {pkgs, ...}: {
              home-manager.users.simone = hm: {
                programs.alacritty = {
                  enable = true;
                  # use a color scheme from the overlay
                  settings.general.import = [pkgs.alacritty-theme.gruvbox_dark];
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
