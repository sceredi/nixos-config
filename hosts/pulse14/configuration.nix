{ config, lib, pkgs, inputs, ... }: {
  imports = with inputs.self.nixosModules; [
    ./disks.nix
    ./hardware-configuration.nix
    users-simone
    dotfiles-pulse14
    profiles-gnome
    editors-default
    langs-default
    mixins-bluetooth
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
    # mixins-samba
    mixins-syncthing
    mixins-tmux
    mixins-usb
    mixins-zerotierone
    mixins-zram
    profiles-avahi
    # profiles-awesomewm
    profiles-docker
    # profiles-hypr
    # profiles-i3
    profiles-pipewire
    profiles-sway
    profiles-uni
    profiles-virtualization
  ];

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  nixpkgs = {
    # I'm sorry Stallman-taichou
    config = {
      allowUnfree = true;
      permittedInsecurePackages =
        # Remove once obsidian decides update its elecron version
        [ "electron-27.3.11" "electron-29.4.6" ];
    };
  };

  home-manager = {
    backupFileExtension = "backup11";
    useGlobalPkgs = true;
    useUserPackages = true;
    users = import "${inputs.self}/users";
    extraSpecialArgs = {
      inherit inputs;
      headless = false;
    };
  };

  users.users.simone.extraGroups = [ "video" ];

  nix = {
    # From flake-utils-plus
    generateNixPathFromInputs = true;
    generateRegistryFromInputs = true;
    linkInputs = true;
  };

  networking = {
    firewall = { enable = true; };
    hostName = "pulse14";
    # useNetworkd = true;
    # wireless = {
    #   userControlled.enable = true;
    #   enable = true;
    #   interfaces = [ "wlp1s0" ];
    # };
    networkmanager.enable = true;
    nat = {
      enable = true;
      internalInterfaces = [ "ve-+" ];
      externalInterface = "ens3";
      # Lazy IPv6 connectivity for the container
      enableIPv6 = true;
    };
  };

  services = {
    # Some folks don't like the correct shebang
    envfs = {
      enable = true;
      extraFallbackPathCommands = "ln -s $''{pkgs.bash}/bin/bash $out/bash";
    };

    thermald.enable = true;
    tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        CPU_MAX_PERF_ON_AC = "100";
        CPU_MAX_PERF_ON_BAT = "30";
      };
    };
    logind.killUserProcesses = true;
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
      efi = { canTouchEfiVariables = true; };
    };
    kernelParams = [ "amdgpu.dcdebugmask=0x10" ];
  };

  # I use zsh btw
  environment.shells = with pkgs; [ zsh ];
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
  ];

  system.stateVersion = "23.11";
}
