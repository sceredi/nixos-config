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
    };
  };
}
