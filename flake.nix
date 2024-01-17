{
  description = "My flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:nixos/nixos-hardware";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    utils = {
      url = "github:gytis-ivaskevicius/flake-utils-plus";
    };
  };
  
  outputs = 
    { self
    , nixpkgs
    , nixos-hardware
    , home-manager
    , utils
    , ...
    } @ inputs: {
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
	  ];
	  specialArgs = { inherit inputs; };
	};
      };
    };
}
