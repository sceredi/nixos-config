# Emacs is my main driver. I'm the author of Doom Emacs
# https://github.com/doomemacs. This module sets it up to meet my particular
# Doomy needs.

{
  inputs,
  lib,
  pkgs,
  ...
}:

with lib;
let
  emacs =
    with pkgs;
    (emacsPackagesFor emacs-git-pgtk).emacsWithPackages (
      epkgs: with epkgs; [
        treesit-grammars.with-all-grammars
        vterm
        mu4e
      ]
    );
in
{
  config = {
    services.emacs.enable = true;

    nixpkgs.overlays = [
      inputs.emacs-overlay.overlays.default
    ];

    home-manager.users.simone =
      { pkgs, ... }:
      {

        home.packages = with pkgs; [
          # (mkLauncherEntry "Emacs (Debug Mode)" {
          #   description = "Start Emacs in debug mode";
          #   icon = "emacs";
          #   exec = "${emacs}/bin/emacs --debug-init";
          # })

          ## Emacs itself
          binutils # native-comp needs 'as', provided by this
          emacs # HEAD + native-comp

          ## Doom dependencies
          git
          ripgrep
          gnutls # for TLS connectivity

          ## Optional dependencies
          fd # faster projectile indexing
          imagemagick # for image-dired
          pinentry-emacs # in-emacs gnupg prompts
          zstd # for undo-fu-session/undo-tree compression

          ## Module dependencies
          # :email mu4e
          mu
          isync
          # :checkers spell
          (aspellWithDicts (
            ds: with ds; [
              en
              en-computers
              en-science
              it
            ]
          ))
          # :tools editorconfig
          editorconfig-core-c # per-project style config
          # :tools lookup & :lang org +roam
          sqlite
          # :lang cc
          clang-tools
          # :lang latex & :lang org (latex previews)
          texlive.combined.scheme-full
          # :lang beancount
          beancount
          fava
          # :lang nix
          age
        ];
      };

    environment.variables = {
      PATH = [ "$XDG_CONFIG_HOME/emacs/bin" ];
      DOOMDIR = [ "$XDG_CONFIG_HOME/doom" ];
    };
    fonts.packages = [ pkgs.nerd-fonts.symbols-only ];
  };
}
