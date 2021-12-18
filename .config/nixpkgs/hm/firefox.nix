{ pkgs, config, ... }:
let
  nur-pkgs = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") { 
    inherit pkgs; 
  } ; 
in
{
  programs.firefox = {
    enable = true;
    package = (pkgs.callPackage ../custom-pkgs/firefox { });
    profiles.builditluc = {
      isDefault = true;
    };
    extensions = with nur-pkgs.repos.rycee.firefox-addons; [
      ecosia
      darkreader
      refined-github
      kristofferhagen-nord-theme
    ];
  };
}
