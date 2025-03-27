# Emacs is my main driver. I'm the author of Doom Emacs
# https://github.com/doomemacs. This module sets it up to meet my particular
# Doomy needs.

{ inputs, pkgs, ... }:
{
  config = {
    nixpkgs.overlays = [ inputs.emacs-overlay.overlays.default ];

    home-manager.users.simone =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [ emacs-git ];
      };
    environment.variables.PATH = [ "$XDG_CONFIG_HOME/emacs/bin" ];

    fonts.packages = [ pkgs.nerd-fonts.symbols-only ];
  };
}
