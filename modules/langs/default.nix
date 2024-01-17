{
  home-manager.users.simone = { pkgs, ... }: {
    imports = [
      # if some langs need a not trivial configuration
    ];

    home.packages = with pkgs; [
      # nix
      nixpkgs-lint
      nixpkgs-fmt
      nixfmt

      # c
      gcc
      gnumake
      cmake
      autoconf
      automake
      libtool

      # node
      nodejs

      # go
      go

      # rust
      rustup

      # jvm stuff
      jdk
      kotlin
      gradle
      scala_3
      sbt

      # erlang stuff
      erlang
      elixir
      gleam

      # ruby
      ruby

      # php
      php

      # latex
      texlive.combined.scheme-full

    ];
  };
}
