{
  services = {
    xserver = {
      # Enable the X11 windowing system.
      videoDrivers = ["modesetting"];
      enable = true;
    };
    # Enable the GNOME Desktop Environment.
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;

    # Enable CUPS to print documents.
    printing.enable = true;

    # Enable sound.
    # sound.enable = true;

    # Enable touchpad support (enabled default in most desktopManager).
    libinput.enable = true;
  };
}
