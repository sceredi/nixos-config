{
  imports = [
    # if some langs need a not trivial configuration
    ./pythonPackages.nix
    ./tools.nix
  ];
  config = {
    home-manager.users.simone = {pkgs, ...}: {
      home.packages = with pkgs; [
        # nix
        nixfmt-rfc-style
        statix

        # c
        clang
        clang-tools
        # gcc
        gnumake
        cmake
        autoconf
        automake
        libtool
        stdenv.cc.cc.lib
        glibc
        zlib

        # node
        nodejs
        typescript
        typescript-language-server
        vue-language-server

        # go
        go
        gopls
        air

        # ocaml
        ocaml
        opam

        # rust
        rustup

        # jvm stuff
        jdk
        jdt-language-server
        kotlin
        (callPackage gradle-packages.gradle_8 {java = jdk;})
        scala_3
        sbt
        coursier
        scala-cli

        # erlang stuff
        erlang
        elixir
        gleam
        rebar3

        # ruby
        ruby
        libsodium

        # php
        php83
        php83Packages.composer

        # lua
        luajitPackages.luarocks

        # latex
        texlive.combined.scheme-full

        # typst
        typst
        tinymist

        # zig
        zig
        zls
      ];
    };
  };
}
