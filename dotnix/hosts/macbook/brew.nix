{ config, pkgs, ... }:
{
  homebrew = {
    enable = true;
    cleanup = "zap";
    taps = [
      "homebrew/bundle" 
      "homebrew/cask" 
      "homebrew/core" 
    ];
    brews = [
      "lolcat"
    ];
    casks = [
      "steam"
      "docker"
      "discord"
      "obs"
      "alacritty"
      "pycharm"
      "rectangle"
    ];
    masApps = {
       "GoodNotes" = 1444383602;
       "WhatsApp" = 1147396723;
       "iStudiez" = 402989379;
       "OneDrive" = 823766827;
       "Enpass" = 732710998;
     };
  };
}
