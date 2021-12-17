{ pkgs, config, ... }:
let
  colorscheme = (import ../colors.nix).colorscheme;
in
{
  programs.direnv = {
    enable = true;
    nix-direnv = {
      enable = true;
    };
  };
}
