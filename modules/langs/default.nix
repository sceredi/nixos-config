{
  imports = [
    # if some langs need a not trivial configuration
    ./pythonPackages.nix
    ./tools.nix
  ];
  config = {
    documentation = {
      enable = true;
      man.enable = true;
      dev.enable = true;
    };
    home-manager.users.simone =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          # nix
          nixd
          nixfmt
          statix

          # c
          clang-tools
          gcc
          gnumake
          cmake
          gdb
          autoconf
          automake
          glslang
          libtool
          stdenv.cc.cc.lib
          glibc
          zlib

          # c#
          csharpier

          # d2
          d2

          #docker
          dockfmt

          # node
          nodejs
          typescript
          typescript-language-server
          vue-language-server
          copilot-language-server
          js-beautify

          # go
          go
          gopls
          air
          delve
          golangci-lint
          gomodifytags
          gotests
          gore

          # protobuf
          protobuf

          # ocaml
          ocaml
          opam
          ocamlPackages.merlin

          # rust
          cargo
          rustc
          rust-analyzer
          rustfmt
          clippy

          # jvm stuff
          (jdk.override { enableJavaFX = true; })
          jdt-language-server
          kotlin
          ktlint
          # (callPackage gradle-packages.gradle_8 {java = jdk;})
          scala_3
          sbt
          coursier
          scala-cli
          scalafmt
          metals

          # erlang stuff
          beamPackages.erlang
          beamPackages.elixir
          gleam
          rebar3

          # html
          html-tidy
          stylelint

          # kubernetes
          k9s
          kubectx

          # ruby
          ruby
          libsodium

          # php
          php83
          php83Packages.composer

          # lua
          luajitPackages.luarocks

          # md
          pandoc

          # latex
          texliveFull
          texlivePackages.latexmk

          # sh
          shfmt
          shellcheck

          # terraform
          terraform

          # typst
          typst
          tinymist

          # yaml
          yaml-language-server

          # xml
          libxml2

          # zig
          zig
          # zls
        ];
      };
    environment.variables = {
      PATH = [
        "/home/simone/.cargo/bin"
        "/home/simone/go/bin/"
      ];
    };
  };
}
