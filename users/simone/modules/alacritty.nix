{
  programs.alacritty = {
    enable = true;
    settings = {
      window = { opacity = 0.98; };
      font = {
        size = 14;
        normal = {
          family = "JetBrains Mono";
          style = "Regular";
        };
      };
    };
  };
  home.sessionVariables = { TERM = "alacritty"; };
}
