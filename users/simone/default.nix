{pkgs, ...}: let
  myAliases = {
    cd = "z"; # enhanced cd with zoxide
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
    ta = "tmux a";

    launch-argos = ''echo "will listen on localhost:6080" && docker run -p 6080:80 -v /home/simone/Public/IRS:/dev/simone tjferrara/argos3:latest'';

    vim = "nvim";

    shutdownsafe = "sudo shutdown now";
    rebootsafe = "sudo reboot now";

    idea = "idea-ultimate >/dev/null 2>&1 &";
    pycharm = "pycharm-professional >/dev/null 2>&1 &";

    e = ''pgrep emacs && emacsclient -n "$@" || emacs -nw "$@"'';
    ediff = ''emacs -nw --eval "(ediff-files \"$1\" \"$2\")";'';
    eman = ''emacs -nw --eval "(switch-to-buffer (man \"$1\"))";'';
    ekill = ''emacsclient --eval '(kill-emacs)';'';
  };
in {
  imports = [./desktop.nix];

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
      timer
      lolcat
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
        plugins = [
          "direnv"
          "git"
        ];
      };
      autosuggestion.enable = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      shellAliases = myAliases;
      initContent = ''
        bindkey '^y' autosuggest-accept
        bindkey '^r' history-incremental-search-backward
        bindkey -s ^f "tmux-sessionizer\n"
        export NIX_LD=$(nix eval --impure --raw --expr 'let pkgs = import <nixpkgs> {}; NIX_LD = pkgs.lib.fileContents "${pkgs.stdenv.cc}/nix-support/dynamic-linker"; in NIX_LD')
        eval $(opam env)
        export GPG_TTY=$(tty)

        # pomodoro
        typeset -A pomo_options
        pomo_options[study]=25
        pomo_options[work]=45
        pomo_options[short-break]=5
        pomo_options[long-break]=10

        pomodoro () {
          if [[ -n "$1" && -n "''${pomo_options[$1]}" ]]; then
            val=$1
            echo "$val" | lolcat
            timer ''${pomo_options[$val]}m
            notify-send Pomodoro "$val session done"
            spd-say "$val session done"
          fi
        }

        alias wo="pomodoro work"
        alias st="pomodoro study"
        alias lbr="pomodoro long-break"
        alias sbr="pomodoro short-break"
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
        scala = {
          disabled = true;
        };
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
