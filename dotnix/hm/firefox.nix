{ config, pkgs, ... }:
{
  programs.firefox = {
    enable = true;
    profiles.builditluc.isDefault = true;
    extensions = with pkgs.nur.repos.rycee.firefox-addons; [
      ecosia
      darkreader
      refined-github
      kristofferhagen-nord-theme
    ];
  };
}
