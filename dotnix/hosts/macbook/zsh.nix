{ config, pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = false;
  };
}
