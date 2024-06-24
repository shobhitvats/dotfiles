{ config, pkgs, ... }:
{

  fonts.packages = with pkgs ; [
    open-sans
    noto-fonts
    noto-fonts-color-emoji
    nerdfonts
  ];

}
