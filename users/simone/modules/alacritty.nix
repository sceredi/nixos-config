{
  programs = {
    alacritty = {
      enable = true;
      settings = {
        window = {
          opacity = 1;
        };
        font = {
          size = 20;
          normal = {
            family = "Jetbrains Mono";
            style = "Regular";
          };
        };
      };
    };
    kitty = {
      enable = true;
      font = {
        size = 20;
        name = "Jetbrains Mono";
      };
      shellIntegration.mode = "no-cursor";
      settings = {
        background = "#282828";
        foreground = "#ebdbb2";

        cursor = "#928374";

        selection_foreground = "#928374";
        selection_background = "#3c3836";

        color0 = "#665c54";
        color8 = "#928374";

        color1 = "#cc241d";
        color9 = "#fb4934";

        color2 = "#98971a";
        color10 = "#b8bb26";

        color3 = "#d79921";
        color11 = "#fabd2f";

        color4 = "#458588";
        color12 = "#83a598";

        color5 = "#b16286";
        color13 = "#d3869b";

        color6 = "#689d6a";
        color14 = "#8ec07c";

        color7 = "#a89984";
        color15 = "#928374";
        # foreground = "#e0def4";
        # background = "#232136";
        # selection_foreground = "#e0def4";
        # selection_background = "#44415a";
        #
        # cursor = "#56526e";
        # cursor_text_color = "#e0def4";
        #
        # url_color = "#c4a7e7";
        #
        # active_tab_foreground = "#e0def4";
        # active_tab_background = "#393552";
        # inactive_tab_foreground = "#6e6a86";
        # inactive_tab_background = "#232136";
        #
        # active_border_color = "#3e8fb0";
        # inactive_border_color = "#44415a";
        #
        # # black
        # color0 = "#393552";
        # color8 = "#6e6a86";
        #
        # # red
        # color1 = "#eb6f92";
        # color9 = "#eb6f92";
        #
        # # green
        # color2 = "#3e8fb0";
        # color10 = "#3e8fb0";
        #
        # # yellow
        # color3 = "#f6c177";
        # color11 = "#f6c177";
        #
        # # blue
        # color4 = "#9ccfd8";
        # color12 = "#9ccfd8";
        #
        # # magenta
        # color5 = "#c4a7e7";
        # color13 = "#c4a7e7";
        #
        # # cyan
        # color6 = "#ea9a97";
        # color14 = "#ea9a97";
        #
        # # white
        # color7 = "#e0def4";
        # color15 = "#e0def4";
      };
    };
  };
}
