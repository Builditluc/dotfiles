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
      "onlyoffice"
      "discord"
      "obs"
      "alacritty"
      "virtualbox"
    ];
    masApps = {
      "Dark Reader" = 1438243180;
       "GoodNotes" = 1444383602;
       "WhatsApp" = 1147396723;
       "iStudiez" = 402989379;
       "OneDrive" = 823766827;
       "Refined Github" = 1519867270;
       "Enpass" = 732710998;
     };
  };
}
