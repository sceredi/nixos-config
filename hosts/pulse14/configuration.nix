{ config, lib, pkgs, inputs, ... }: {
  imports = with inputs.self.nixosModules; [
    ./disks.nix
    ./hardware-configuration.nix
    users-simone
    dotfiles-pulse14
    # profiles-gnome
    editors-default
    langs-default
    mixins-bluetooth
    mixins-common
    mixins-discord
    mixins-flatpak
    mixins-fonts
    mixins-gc
    mixins-keyboards
    mixins-openssh
    mixins-printing
    mixins-tmux
    mixins-zram
    profiles-avahi
    profiles-docker
    profiles-pipewire
    profiles-sway
    profiles-uni
    profiles-virtualization
  ];

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  # I'm sorry Stallman-taichou
  nixpkgs.config.allowUnfree = true;

  home-manager = {
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
  };

  boot = {
    kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
      };
      efi = { canTouchEfiVariables = true; };
    };
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
    firefox
    vim
    tmux
    mpv
    gnumake
    htop
    git
  ];

  system.stateVersion = "23.11";
}
