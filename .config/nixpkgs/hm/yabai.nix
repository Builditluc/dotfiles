{ pkgs, config, ... }: 
{
  home.file.yabai = {
    executable = true;
    target = ".config/yabai/yabairc";
    text = ''
      #!/usr/bin/env sh

      yabai -m config layout              bsp
      yabai -m config mouse_follows_focus true
      yabai -m config split_ratio         .5

      # padding
      yabai -m config top_padding         10
      yabai -m config bottom_padding      10
      yabai -m config left_padding        10
      yabai -m config right_padding       10
      yabai -m config window_gap          10

      yabai -m config window_opacity      false
      yabai -m config window_shadow       false
      yabai -m config window_placement    second_child

      yabai -m config external_bar all:26:0

      # rules
      yabai -m rule --add app="^System Preferences$" manage=off
      yabai -m rule --add app="^Mail$" manage=off
      yabai -m rule --add app="^Enpass$" manage=off

      echo "yabai configuration loaded.."
    '';
  };

  home.file.skhd = {
    target = ".config/skhd/skhdrc";
    text = ''
      # focus window
      cmd + shift - h : yabai -m window --focus west
      cmd + shift - j : yabai -m window --focus south 
      cmd + shift - k : yabai -m window --focus north
      cmd + shift - l : yabai -m window --focus east

      # swap managed window
      shift + alt - h : yabai -m window --swap west
      shift + alt - j : yabai -m window --swap south 
      shift + alt - k : yabai -m window --swap north
      shift + alt - l : yabai -m window --swap east

      # fast focus desktop
      shift + alt - 0 : yabai -m space --focus recent
      shift + alt - 1 : yabai -m space --focus 1
      shift + alt - 2 : yabai -m space --focus 2 
      shift + alt - 3 : yabai -m space --focus 3 

      # send window to desktop and follow focus
      cmd + shift - - : yabai -m window --space next; yabai -m space --focus next
    '';
  };
}
