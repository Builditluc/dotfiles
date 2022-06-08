{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    feh
  ];

  xsession = {
    enable = true;
    initExtra = ''
      feh --image-bg black --bg-center "$HOME/wallpaper.png"
    '';
    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      config = ./config.hs;
    };
  };
}
