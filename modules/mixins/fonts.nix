{
  config,
  pkgs,
  lib,
  ...
}: {
  fonts.enableDefaultPackages = true;
  fonts.packages = with pkgs; [
    fira-code
    fira-code-symbols
    terminus_font
    jetbrains-mono
    powerline-fonts
    gelasio
    nerd-fonts.jetbrains-mono
    iosevka
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    source-code-pro
    ttf_bitstream_vera
    terminus_font_ttf
    iosevka
  ];
}
