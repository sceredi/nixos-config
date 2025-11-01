{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = with inputs.self.nixosModules; [
    # ./hardware-configuration.nix
    users-simone
    dotfiles-pulse14
    editors-default
    langs-default
    mixins-common
    mixins-discord
    mixins-flatpak
    mixins-fonts
    mixins-gc
    mixins-keyboards
    mixins-nixld
    mixins-openssh
    mixins-picom
    mixins-printing
    mixins-syncthing
    mixins-tailscale
    mixins-tmux
    mixins-usb
    mixins-zoxide
    mixins-zram
    profiles-avahi
    profiles-docker
    profiles-hypr
    profiles-pipewire
    profiles-uni
    profiles-virtualization
  ];
  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
    '';

    settings = {
      substituters = [
        "https://nix-community.cachix.org"
        "https://hyprland.cachix.org"
      ];
      trusted-substituters = ["https://hyprland.cachix.org"];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];
    };

    # From flake-utils-plus
    generateNixPathFromInputs = true;
    generateRegistryFromInputs = true;
    linkInputs = true;
  };

  nixpkgs = {
    # I'm sorry Stallman-taichou
    config = {
      allowUnfree = true;
      permittedInsecurePackages =
        # Remove once obsidian decides update its elecron version
        [
          "electron-27.3.11"
          "electron-29.4.6"
        ];
    };
  };

  services.xserver.videoDrivers = ["nvidia"];
  hardware.opengl.enable = true;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;

  # For CUDA support
  hardware.opengl.driSupport = true;
  hardware.opengl.driSupport32Bit = true;

  home-manager = {
    backupFileExtension = "backup1";
    useGlobalPkgs = true;
    useUserPackages = true;
    users = import "${inputs.self}/users";
    extraSpecialArgs = {
      inherit inputs;
      headless = false;
    };
  };

  users.users.simone.extraGroups = ["video"];
  powerManagement.enable = true;

  networking = {
    firewall = {
      enable = true;
    };
    hostName = "reactor";
  };

  services = {
    logind.settings.Login.KillUserProcesses = true;
    power-profiles-daemon.enable = false;
    udev.extraRules = ''
            # Rules for Oryx web flashing and live training
      KERNEL=="hidraw*", ATTRS{idVendor}=="16c0", MODE="0664", GROUP="plugdev"
      KERNEL=="hidraw*", ATTRS{idVendor}=="3297", MODE="0664", GROUP="plugdev"

      # Legacy rules for live training over webusb (Not needed for firmware v21+)
        # Rule for all ZSA keyboards
        SUBSYSTEM=="usb", ATTR{idVendor}=="3297", GROUP="plugdev"
        # Rule for the Moonlander
        SUBSYSTEM=="usb", ATTR{idVendor}=="3297", ATTR{idProduct}=="1969", GROUP="plugdev"
        # Rule for the Ergodox EZ
        SUBSYSTEM=="usb", ATTR{idVendor}=="feed", ATTR{idProduct}=="1307", GROUP="plugdev"
        # Rule for the Planck EZ
        SUBSYSTEM=="usb", ATTR{idVendor}=="feed", ATTR{idProduct}=="6060", GROUP="plugdev"

      # Wally Flashing rules for the Ergodox EZ
      ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789B]?", ENV{ID_MM_DEVICE_IGNORE}="1"
      ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789A]?", ENV{MTP_NO_PROBE}="1"
      SUBSYSTEMS=="usb", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789ABCD]?", MODE:="0666"
      KERNEL=="ttyACM*", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789B]?", MODE:="0666"

      # Keymapp / Wally Flashing rules for the Moonlander and Planck EZ
      SUBSYSTEMS=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="df11", MODE:="0666", SYMLINK+="stm32_dfu"
      # Keymapp Flashing rules for the Voyager
      SUBSYSTEMS=="usb", ATTRS{idVendor}=="3297", MODE:="0666", SYMLINK+="ignition_dfu"
    '';
  };

  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
      };
      efi = {
        canTouchEfiVariables = true;
      };
    };
  };

  # I use zsh btw
  environment.shells = with pkgs; [zsh];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  time.timeZone = "Europe/Rome";
  location.provider = "geoclue2";

  environment.systemPackages = with pkgs; [
    wget
    vim
    tmux
    mpv
    gnumake
    htop
    git
    inputs.sceredi-nix-cats.packages."x86_64-linux".default
  ];

  system.stateVersion = "25.05";
}
