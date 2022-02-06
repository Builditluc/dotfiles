{ config, pkgs, ... }: 
let
  colorscheme = (import ./colors.nix).colorscheme;
in
{
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
  home-manager.users.builditluc.imports = [ 
    ./hm/alacritty.nix
    ./hm/direnv.nix
    ./hm/firefox.nix
    ./hm/git.nix
    ./hm/nvim.nix
    ./hm/yabai.nix
    ./hm/zsh.nix
    ./home.nix 
  ];

  services.yabai = {
    enable = true;
    enableScriptingAddition = true;
    package = pkgs.yabai;
  };

  services.skhd = {
    enable = true;
    package = pkgs.skhd;
  };

  services.spacebar = {
    enable = true;
    package = pkgs.spacebar;

    config = {
      position                   = "top";
      display                    = "all";
      height                     = 26;

      title                      = "on";
      spaces                     = "on";
      clock                      = "on";
      power                      = "on";

      text_font = ''"FiraCode Nerd Font:Regular:12.0"'';
      icon_font = ''"FiraCode Nerd Font:Regular:12.0"'';

      padding_left               = 20;
      padding_right              = 20;

      spacing_left               = 25;
      spacing_right              = 15;

      # background_color = "0x${colorscheme.colors.base01}";
      background_color           = "0xff202020";
      foreground_color           = "0xffa8a8a8";
      power_icon_color           = "0xffcd950c";
      battery_icon_color         = "0xffd75f5f";
      dnd_icon_color             = "0xffa8a8a8";
      clock_icon_color           = "0xffa8a8a8";

      power_icon_strip           = " ";
      space_icon                 = "•";
      space_icon_strip           = "1 2 3 4 5 6 7 8 9 10";
      spaces_for_all_displays    = "on";

      display_separator          = "on";
      display_separator_icon     = "";

      space_icon_color           = "0xff458588";
      space_icon_color_secondary = "0xff78c4d4";
      space_icon_color_tertiary  = "0xfffff9b0";

      clock_icon                 = "";
      dnd_icon                   = "";
      clock_format               = ''"%d/%m/%y %R"'';

      right_shell                = "on";
      right_shell_icon           = "";
      right_shell_command        = "whoami"; 
    };
  };

  homebrew.enable = true;
  homebrew.cleanup = "zap";
  homebrew.taps = [ 
    "homebrew/bundle" 
    "homebrew/cask" 
    "homebrew/core" 
    "clangen/musikcube"
  ];
  homebrew.brews = [ 
    "python@3.10" 
    "bpytop" 
    "iperf3" 
    "lolcat" 
    "pinentry" 
    "musikcube"
  ];
  homebrew.casks = [ 
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
    ln -sf ${pkgs.callPackage ./custom-pkgs/firefox { } }/Applications/Firefox.app /Applications
  '';
}
