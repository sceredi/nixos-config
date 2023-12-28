{
  description = "Flake of LibrePhoenix";

  outputs = { self, nixpkgs, home-manager, stylix, rust-overlay, ... }@inputs:
  let
    # ---- SYSTEM SETTINGS ---- #
    system = "x86_64-linux"; # system arch
    hostname = "nixos-vm"; # hostname
    profile = "uni"; # select a profile defined from my profiles directory
    timezone = "Europe/Rome"; # select timezone
    locale = "en_US.UTF-8"; # select locale

    # ----- USER SETTINGS ----- #
    username = "simone"; # username
    name = "Simone"; # name/identifier
    email = "ceredi.simone.iti@gmail.com"; # email (used for certain configurations)
    dotfilesDir = "~/.dotfiles"; # absolute path of the local repo
    theme = "catpuccin"; # selcted theme from my themes directory (./themes/)
    wm = "kde"; # Selected window manager or desktop environment; must select one in both ./user/wm/ and ./system/wm/
    wmType = "x11"; # x11 or wayland
    browser = "firefox"; # Default browser; must select one from ./user/app/browser/
    editor = "nvim"; # Default editor;
    term = "kitty"; # Default terminal command;
    font = "JetBrains Mono"; # Selected font
    fontPkg = pkgs.jetbrains-mono; # Font package

    # editor spawning translator
    # generates a command that can be used to spawn editor inside a gui
    # EDITOR and TERM session variables must be set in home.nix or other module
    # I set the session variable SPAWNEDITOR to this in my home.nix for convenience
    spawnEditor = if ((editor == "vim") || (editor == "nvim") || (editor == "nano")) then "exec " + term + " -e " + editor else editor;

    # create patched nixpkgs
    nixpkgs-patched = (import nixpkgs { inherit system; }).applyPatches {
      name = "nixpkgs-patched";
      src = nixpkgs;
      patches = [];
    };

    # configure pkgs
    pkgs = import nixpkgs-patched {
      inherit system;
      config = { allowUnfree = true;
                 allowUnfreePredicate = (_: true); };
      overlays = [ rust-overlay.overlays.default ];
    };

    # configure lib
    lib = nixpkgs.lib;

  in {
    homeConfigurations = {
      user = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ (./. + "/profiles"+("/"+profile)+"/home.nix") ]; # load home.nix from selected PROFILE
          extraSpecialArgs = {
            # pass config variables from above
            inherit username;
            inherit name;
            inherit hostname;
            inherit profile;
            inherit email;
            inherit dotfilesDir;
            inherit theme;
            inherit font;
            inherit fontPkg;
            inherit wm;
            inherit wmType;
            inherit browser;
            inherit editor;
            inherit term;
            inherit spawnEditor;
            inherit (inputs) stylix;
          };
      };
    };
    nixosConfigurations = {
      system = lib.nixosSystem {
        inherit system;
        modules = [ (./. + "/profiles"+("/"+profile)+"/configuration.nix") ]; # load configuration.nix from selected PROFILE
        specialArgs = {
          # pass config variables from above
          inherit username;
          inherit name;
          inherit hostname;
          inherit timezone;
          inherit locale;
          inherit theme;
          inherit font;
          inherit fontPkg;
          inherit wm;
          inherit (inputs) stylix;
          inherit (inputs) blocklist-hosts;
        };
      };
    };
  };

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    stylix.url = "github:danth/stylix";
    rust-overlay.url = "github:oxalica/rust-overlay";
  };
}
