{
  imports = [
    # if some langs need a not trivial configuration
    ./pythonPackages.nix
    ./tools.nix
  ];
  config = {
    home-manager.users.simone = { pkgs, ... }: {

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
        coursier

        # erlang stuff
        erlang
        elixir
        gleam

        # ruby
        ruby

        # php
        php83
        php83Packages.composer

        # lua
        luajitPackages.luarocks

        # julia
        julia

        # latex
        texlive.combined.scheme-full

      ];
    };
  };
}