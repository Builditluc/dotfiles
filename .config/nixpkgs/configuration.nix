{ config, pkgs, ... }: {
  imports = [ <home-manager/nix-darwin> ];

  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = true;
  };

  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;

  programs.zsh.enable = true;
  programs.zsh.enableCompletion = false;

  users.users.builditluc = {
    name = "builditluc";
    home = "/Users/builditluc";
  };

  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;
  home-manager.users.builditluc.imports = [ ./home.nix ];

  homebrew.enable = true;
  homebrew.cleanup = "zap";
  homebrew.taps = [ "homebrew/bundle" "homebrew/cask" "homebrew/core" ];
  homebrew.brews = [ 
    "python@3.10" 
    "bpytop" 
    "iperf3" 
    "lolcat" 
    "pinentry" 
  ];
  homebrew.casks = [ 
    "firefox" 
    "steam" 
    "rectangle" 
    "docker" 
    "onlyoffice" 
    "discord" 
    "betterdiscord-installer" 
    "obs" 
    "alacritty" 
    "enpass" 
  ];

  homebrew.masApps = {
    "Dark Reader" = 1438243180;
    "GoodNotes" = 1444383602;
    "WhatsApp" = 1147396723;
    "iStudiez" = 402989379;
    "OneDrive" = 823766827;
    "Refined Github" = 1519867270;
    "Enpass" = 732710998;
  };

  fonts.enableFontDir = true;
  fonts.fonts = [ pkgs.nerdfonts ];

  system.defaults = {
    alf.globalstate = 1;
    trackpad.ActuationStrength = 0;
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
    loginwindow.autoLoginUser = "builditluc";
  };

  system.activationScripts.extraUserActivation.text = ''
    defaults write com.knollsoft.Rectangle gapSize -int 10
    osascript -e 'tell application "Finder" to set desktop picture to POSIX file "/Users/builditluc/wallpaper.png"'
  '';
}
