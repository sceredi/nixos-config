# Emacs is my main driver. I'm the author of Doom Emacs
# https://github.com/doomemacs. This module sets it up to meet my particular
# Doomy needs.
{
  pkgs,
  ...
}:
{
  config = {
    home-manager.users.simone = {
      programs.doom-emacs = {
        enable = true;
      };
    };
    fonts.packages = [ pkgs.nerd-fonts.symbols-only ];
  };
}
