{ config, pkgs, ... }:
let 
  myAliases = {
    la="ls -Alh"; # show hidden files
    ls="ls -aFh --color=always"; # add colors and file type extensions
    lx="ls -lXBh"; # sort by extension
    lk="ls -lSrh"; # sort by size
    lc="ls -lcrh"; # sort by change time
    lu="ls -lurh"; # sort by access time
    lr="ls -lRh"; # recursive ls
    lt="ls -ltrh"; # sort by date
    lm="ls -alh |more"; # pipe through 'more'
    lw="ls -xAh"; # wide listing format
    ll="ls -Fls"; # long listing format
    labc="ls -lap"; #alphabetical sort
    lf="ls -l | egrep -v '^d'"; # files only
    ldir="ls -l | egrep '^d'"; # directories only
    vim="nvim";
    
    shutdownsafe="sudo shutdown now";
    rebootsafe="sudo reboot now";

  };
  in
  {
    programs.zsh = {
      enable = true;
      enableAutosuggestions = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      shellAliases = myAliases;
      initExtra = ''
        bindkey '^ ' autosuggest-accept
      '';
      oh-my-zsh = {
        enable = true;
        theme = "robbyrussell";
      };
    };

    programs.bash = {
      enable = true;
      enableCompletion = true;
      shellAliases = myAliases;
    };

    home.packages = with pkgs; [
      direnv nix-direnv
    ];

    programs.direnv.enable = true;
    programs.direnv.enableZshIntegration = true;
    programs.direnv.nix-direnv.enable = true;


  }
