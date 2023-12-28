{ config, lib, pkgs, stylix, username, email, dotfilesDir, theme, wm, browser, editor, spawnEditor, term, ... }:
{
  home.username = username;
  home.homeDirectory = "/home/"+username;

  programs.home-manager.enable = true;

  imports = [
    ../../user/shell/sh.nix
    ../../user/shell/cli-collection.nix
    ../../user/app/git/git.nix
    ../../user/app/virtualization/virtualization.nix
    ../../user/app/flatpak/flatpak.nix
    ../../user/lang/cc/cc.nix
    ../../user/hardware/bluetooth.nix
  ];

  home.stateVersion = "23.11";

  home.packages = with pkgs; [
    zsh
    kitty
    firefox
    brave
    git
    libreoffice-fresh
    okular
    dolphin
    gimp-with-plugins
  ];
  
  xdg.enable = true;
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    music = "${config.home.homeDirectory}/Media/Music";
    videos = "${config.home.homeDirectory}/Media/Videos";
    pictures = "${config.home.homeDirectory}/Media/Pictures";
    templates = "${config.home.homeDirectory}/Templates";
    download = "${config.home.homeDirectory}/Downloads";
    documents = "${config.home.homeDirectory}/Documents";
    desktop = null;
    publicShare = null;
    extraConfig = {
      XDG_DOTFILES_DIR = "${config.home.homeDirectory}/.dotfiles";
      XDG_ARCHIVE_DIR = "${config.home.homeDirectory}/Archive";
      XDG_VM_DIR = "${config.home.homeDirectory}/Machines";
      XDG_ORG_DIR = "${config.home.homeDirectory}/Org";
      XDG_PODCAST_DIR = "${config.home.homeDirectory}/Media/Podcasts";
      XDG_BOOK_DIR = "${config.home.homeDirectory}/Media/Books";
    };
  };

  home.sessionVariables = {
    EDITOR = editor;
    SPAWNEDITOR = spawnEditor;
    TERM = term;
    BROWSER = browser;
  };
}
