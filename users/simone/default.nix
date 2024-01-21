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
    vim = "nvim";
    launch = ''function _launch() { nohup "$@" > /dev/null 2>&1 & }; _launch'';

    cat = "bat";

    shutdownsafe = "sudo shutdown now";
    rebootsafe = "sudo reboot now";

  };
in {
  imports = [ ./desktop.nix ];

  home = {
    username = "simone";
    homeDirectory = "/home/simone";
    packages = with pkgs; [ file ripgrep fd unzip btop htop pciutils ];
  };

  programs = {
    zsh = {
      enable = true;
      enableAutosuggestions = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      shellAliases = myAliases;
      initExtra = ''
        bindkey '^ ' autosuggest-accept
        bindkey -s '^f' "tms\n"
      '';
      oh-my-zsh = {
        enable = true;
        theme = "robbyrussell";
      };
    };
    starship = {
      enable = true;
      enableBashIntegration = true;
      settings = {
        username = {
          format = "user: [$user]($style) ";
          show_always = true;
        };
        shlvl = {
          disabled = false;
          format = "$shlvl ▼ ";
          threshold = 4;
        };
      };
    };
    bash = {
      enable = true;
      enableCompletion = true;
      shellAliases = myAliases;
    };
  };

  home.stateVersion = "23.11";
}
