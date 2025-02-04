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
        (callPackage gradle-packages.gradle_8 { java = jdk; })
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

        # zig
        zig
        zls
      ];
    };
  };
}
