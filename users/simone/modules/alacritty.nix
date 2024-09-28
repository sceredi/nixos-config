{
  programs = {
    alacritty = {
      enable = true;
      settings = {
        window = { opacity = 0.98; };
        font = {
          size = 18;
          normal = {
            family = "JetBrains Mono";
            style = "Regular";
          };
        };
      };
    };
    kitty = {
      enable = true;
      font = {
        size = 18;
        name = "JetBrains Mono";
      };
      shellIntegration.mode = "no-cursor";
      settings = {
        foreground = "#2C363C";
        background = "#F0EDEC";
        selection_foreground = "#2C363C";
        selection_background = "#CBD9E3";
        # Cursor colors
        cursor = "#2C363C";
        cursor_text_color = "#F0EDEC";
        # Tab bar colors
        active_tab_foreground = "#2C363C";
        active_tab_background = "#DEB9D6";
        inactive_tab_foreground = "#2C363C";
        inactive_tab_background = "#D6CDC9";
        # black
        color0 = "#F0EDEC";
        color8 = "#CFC1BA";
        # red
        color1 = "#A8334C";
        color9 = "#94253E";
        # green
        color2 = "#4F6C31";
        color10 = "#3F5A22";
        # yellow
        color3 = "#944927";
        color11 = "#803D1C";
        # blue
        color4 = "#286486";
        color12 = "#1D5573";
        # magenta
        color5 = "#88507D";
        color13 = "#7B3B70";
        # cyan
        color6 = "#3B8992";
        color14 = "#2B747C";
        # white
        color7 = "#2C363C";
        color15 = "#4F5E68";
      };
    };
  };
}
