{ config, pkgs, ... }:
{
  programs.eww = {
    enable = true;
    # configDir = "$HOME/dotnix/hm/eww";
    configDir = "/media/psf/Developing/nix/dotnix/hm/eww";
  };
}
