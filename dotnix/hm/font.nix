{ config, pkgs, ... }:
{
  fonts = {
    fonts = [
      pkgs.nerdfonts # this takes sooooooooooo long to build
    ];
  };
}
