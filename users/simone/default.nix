{ config, lib, pkgs, inputs, ... }:
let
  myAliases = {
    la = "ls -Alh"; # show hidden files
    ls = "ls -aFh --color=always"; # add colors and file type extensions
    lx = "ls -lXBh"; # sort by extension
    lk = "ls -lSrh"; # sort by size
    lc = "ls -lcrh"; # sort by change time
    lu = "ls -lurh"; # sort by access time
    lr = "ls -lRh"; # recursive ls
    lt = "ls -ltrh"; # sort by date
    lm = "ls -alh |more"; # pipe through 'more'
    lw = "ls -xAh"; # wide listing format
    ll = "ls -Fls"; # long listing format
    labc = "ls -lap"; # alphabetical sort
    lf = "ls -l | egrep -v '^d'"; # files only
    ldir = "ls -l | egrep '^d'"; # directories only

    launch-argos = ''
      echo "will listen on localhost:6080" && docker run -p 6080:80 -v /home/simone/Public/IRS:/dev/simone tjferrara/argos3:latest'';

    vim = "nvim";

    shutdownsafe = "sudo shutdown now";
    rebootsafe = "sudo reboot now";

    idea = "idea-ultimate >/dev/null 2>&1 &";
    pycharm = "pycharm-professional >/dev/null 2>&1 &";

  };
in {
  imports = [ ./desktop.nix ];

  home = {
    username = "simone";
    homeDirectory = "/home/simone";
    packages = with pkgs; [
      file
      ripgrep
      fd
      unzip
      btop
      htop
      pciutils
      trash-cli
    ];
  };

  programs = {
    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
    zsh = {
      enable = true;
      oh-my-zsh = {
        enable = true;
        plugins = [ "direnv" "git" ];
      };
      autosuggestion.enable = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      shellAliases = myAliases;
      initExtra = ''
        bindkey '^y' autosuggest-accept
        bindkey '^r' history-incremental-search-backward
        bindkey -s ^f "tmux-sessionizer\n"
        export NIX_LD=$(nix eval --impure --raw --expr 'let pkgs = import <nixpkgs> {}; NIX_LD = pkgs.lib.fileContents "${pkgs.stdenv.cc}/nix-support/dynamic-linker"; in NIX_LD')
        eval $(opam env)
        export GPG_TTY=$(tty)
      '';
    };
    starship = {
      enable = true;
      enableBashIntegration = true;
      settings = {
        command_timeout = 1000;
        username = {
          format = "user: [$user]($style) ";
          show_always = true;
        };
        shlvl = {
          disabled = false;
          format = "$shlvl ▼ ";
          threshold = 4;
        };
        scala = { disabled = true; };
      };
    };
    bash = {
      enable = true;
      enableCompletion = true;
      shellAliases = myAliases;
      initExtra = ''
        export NIX_LD=$(nix eval --impure --raw --expr 'let pkgs = import <nixpkgs> {}; NIX_LD = pkgs.lib.fileContents "${pkgs.stdenv.cc}/nix-support/dynamic-linker"; in NIX_LD')
        export GPG_TTY=$(tty)
      '';
    };
  };

  home.stateVersion = "23.11";
}
