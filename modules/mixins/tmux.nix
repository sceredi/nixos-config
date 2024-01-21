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
      bind-key -r f run-shell "tmux neww tms"

      # bind-key -r i run-shell "tmux neww tmux-cht.sh"
    '';
  };
  home-manager.users.simone = { pkgs, ... }: {
    home.packages = with pkgs; [ tmux-sessionizer ];
  };
}
