{ config, pkgs, ... }:
{
  programs.kitty = {
    enable = true;
    environment."LC_ALL" = "en_US.UTF-8";
    font = {
      name = "FiraCode Nerd Font";
      size = 12;
    };
    settings = {
      disable_ligatures = "never";
      shell_integration = "enabled";
      macos_show_window_title_in = "menubar";
    };
    theme = "Nord";
  };
}
