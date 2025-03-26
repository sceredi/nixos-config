{ config, lib, ... }:
{
  programs.wezterm = {
    enable = true;
  };
  home.file = {
    "${config.home.homeDirectory}/.config/wezterm/wezterm.lua" = lib.mkForce {
      source = ./wezterm/wezterm.lua;
    };
    "${config.home.homeDirectory}/.config/wezterm/sessionizer.lua" = {
      source = ./wezterm/sessionizer.lua;
    };
    "${config.home.homeDirectory}/.config/wezterm/colors.toml" = {
      source = ./wezterm/colors.toml;
    };
  };
}
