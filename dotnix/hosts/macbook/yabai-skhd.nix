{ config, pkgs, ... }:
{
  services.yabai = {
    enable = true;
    enableScriptingAddition = true;
    package = pkgs.yabai;
  };

  services.skhd = {
    enable = true;
    package = pkgs.skhd;
  };
}
