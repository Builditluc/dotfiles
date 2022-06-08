{ config, pkgs, ... }:
{
  services.nix-daemon.enable = true;

  system.defaults = {
    alf.globalstate = 1;
    trackpad.ActuationStrength = 0;
    loginwindow.autoLoginUser = "builditluc";
    dock = {
      autohide = true;
      minimize-to-application = true;
      orientation = "left";
      show-recents = false;
    };
    NSGlobalDomain = {
      AppleInterfaceStyle = "Dark";
      AppleShowAllExtensions = true;
      NSAutomaticCapitalizationEnabled = false;
      KeyRepeat = 6;
      PMPrintingExpandedStateForPrint = true;
    };
  };

  #TODO: change necessary settings to enable yabai and skhd
  system.activationScripts.extraUserActivation.text = ''
    osascript -e 'tell application "Finder" to set desktop picture to POSIX file "/Users/builditluc/wallpaper.png"'
    ln -sf ${pkgs.callPackage ../../custom-pkgs/firefox { } }/Applications/Firefox.app /Applications
  '';
  
  fonts.enableFontDir = true;

  imports = [
    ./brew.nix
    ./spacebar.nix
    ./yabai-skhd.nix
    ./zsh.nix
  ];
}
