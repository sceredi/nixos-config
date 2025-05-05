{
  programs.tmux = {
    enable = true;
    escapeTime = 0;
    keyMode = "vi";
    shortcut = "a";
    baseIndex = 1;

    extraConfig = ''
      set -sa terminal-overrides "*:Tc"
      set -g default-terminal "screen-256color"
      set -g status-style 'bg=#333333 fg=#5eacd3'
      unbind C-a
      bind C-a send-prefix

      bind -T copy-mode-vi v send-keys -X begin-selection
      bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel 'xclip -in -selection clipboard'

      # vim-like pane switching
      bind -r ^ last-window
      bind -r k select-pane -U
      bind -r j select-pane -D
      bind -r h select-pane -L
      bind -r l select-pane -R

      bind b new-window -c "#{pane_current_path}"

      # forget the find window.  That is for chumps
      bind-key -r f display-popup -E "tmux-sessionizer"

      bind-key -r e display-popup -E "tms switch"

      bind-key -r i display-popup -E "tms windows"
    '';
  };
  home-manager.users.simone = {pkgs, ...}: {
    home.packages = with pkgs; [
      tmux-sessionizer
      (pkgs.writeShellScriptBin "tmux-sessionizer" ''
        #!/usr/bin/env bash

        if [[ $# -eq 1 ]]; then
            selected=$1
        else
            list_with_git=$(fd -HI -td ^.git$ --max-depth=7 ~/projects ~/notes ~/uni-lab ~/.dotfiles ~/.config ~/exercism ~/probe)
            list_without_git=$(echo "$list_with_git" | awk -F'/.git/' '{print $1}')
            selected=$(echo "$list_without_git" | fzf)
        fi

        if [[ -z $selected ]]; then
            exit 0
        fi

        selected_name=$(basename "$selected" | tr . _)
        tmux_running=$(pgrep tmux)

        if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
            tmux new-session -s "$selected_name" -c "$selected"
            exit 0
        fi

        if ! tmux has-session -t="$selected_name" 2> /dev/null; then
            tmux new-session -ds "$selected_name" -c "$selected"
        fi

        if [[ -z $TMUX ]]; then
            tmux attach -t "$selected_name"
        else
            tmux switch-client -t "$selected_name"
        fi
      '')
    ];
  };
}
