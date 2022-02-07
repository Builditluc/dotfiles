{ pkgs, config, ... }: 
{
  home.file.yabai = {
    executable = true;
    target = ".config/yabai/yabairc";
    text = ''
      #!/usr/bin/env sh

      yabai -m config layout              bsp
      yabai -m config mouse_follows_focus true

      # padding
      yabai -m config top_padding         10
      yabai -m config bottom_padding      10
      yabai -m config left_padding        10
      yabai -m config right_padding       10
      yabai -m config window_gap          10

      yabai -m config window_opacity      false
      yabai -m config window_shadow       false
      yabai -m config window_placement    second_child
      yabai -m config window_topmost      on

      yabai -m config external_bar        all:26:0

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
      alt - h : yabai -m window --focus west
      alt - j : yabai -m window --focus south 
      alt - k : yabai -m window --focus north
      alt - l : yabai -m window --focus east

      # swap managed window
      shift + alt - h : yabai -m window --warp west
      shift + alt - j : yabai -m window --warp south 
      shift + alt - k : yabai -m window --warp north
      shift + alt - l : yabai -m window --warp east

      shift + alt - f : yabai -m window --toggle zoom-fullscreen

      # fast focus desktop
      shift + alt - p : yabai -m space --focus prev
      shift + alt - n : yabai -m space --focus next

      alt - p : yabai -m window --space prev; yabai -m space --focus prev
      alt - n : yabai -m window --space next; yabai -m space --focus next
    '';
  };
}
