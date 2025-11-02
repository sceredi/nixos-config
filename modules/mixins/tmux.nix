{
  programs.tmux = {
    enable = true;
    escapeTime = 0;
    keyMode = "vi";
    shortcut = "a";
    baseIndex = 1;

    extraConfig = ''
      set -g renumber-windows on  # keep numbering sequential
      set -g repeat-time 1000  # increase "prefix-free" window

      set -sa terminal-overrides "*:Tc"
      set -g default-terminal "screen-256color"
      # set -g status-style 'bg=#333333 fg=#5eacd3'

      # Theme: borders
      set -g pane-border-lines simple
      set -g pane-border-style fg=black,bright
      set -g pane-active-border-style fg=magenta

      # Theme: status
      set -g status-style bg=default,fg=magenta,bright,nobold
      set -g status-left ""
      set -g status-right "#[fg=white,bright]#S"

      # Theme: status (windows)
      set -g window-status-current-style "#{?window_zoomed_flag,fg=yellow,fg=white,bright}"
      set -g window-status-bell-style "fg=red,nobold"

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

      bind-key -r o attach-session -c "#{pane_current_path}"
    '';
  };
  home-manager.users.simone = {pkgs, ...}: {
    home.packages = with pkgs; [
      tmux-sessionizer
      (pkgs.writeShellScriptBin "tmux-sessionizer" ''
          #!/usr/bin/env bash

          # Format: "path:min_depth:max_depth"
          # - plain path for direct inclusion
          CONFIGS=(
          "$HOME/projects:1:1"
          "$HOME/uni-lab:2:2"
          "$HOME/uni-lab/PPS/2024:2:2"
          "$HOME/.dotfiles"
          "$HOME/.config/nvim"
          "$HOME/exercism:2:2"
          "$HOME/probe:2:2"
        )

        all_dirs=()

        for entry in "''${CONFIGS[@]}"; do
          if [[ "$entry" == *:*:* ]]; then
            IFS=":" read -r base min max <<< "$entry"
            while IFS= read -r dir; do
              all_dirs+=("$dir")
            done < <(fd -HI -td . "$base" --min-depth="$min" --max-depth="$max")
          else
            all_dirs+=("$entry")
          fi
        done

        if [[ $# -eq 1 ]]; then
          selected=$1
        else
          selected=$(printf "%s\n" "''${all_dirs[@]}" | fzf)
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
