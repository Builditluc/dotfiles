{ config, pkgs, colorscheme, ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        size = 12.0;
        normal = {
          family = "FiraCode Nerd Font";
          style = "Regular";
        };
        bold = {
          family = "FiraCode Nerd Font";
          style = "Bold";
        };
        italic = {
          family = "FiraCode Nerd Font";
          style = "Italic";
        };
      };
      colors = {
        primary = {
          background = "#${colorscheme.colors.base00}";
          foreground = "#${colorscheme.colors.base04}";
        };
        cursor = {
          text = "#${colorscheme.colors.base00}";
          cursor = "#${colorscheme.colors.base04}";
        };
        vi_mode_cursor = {
          text = "#${colorscheme.colors.base00}";
          cursor = "#${colorscheme.colors.base04}";
        };
        selection = {
          text = "CellForeground";
          background = "#${colorscheme.colors.base03}";
        };
        search = {
          matches = {
            foreground = "CellBackground";
            background = "#${colorscheme.colors.base0C}";
          };
          bar = {
            background = "#${colorscheme.colors.base02}";
            foreground = "#${colorscheme.colors.base04}";
          };
        };
        normal = {
          black = "#${colorscheme.colors.base01}";
          red = "#${colorscheme.colors.base08}";
          green = "#${colorscheme.colors.base0B}";
          yellow = "#${colorscheme.colors.base0A}";
          blue = "#${colorscheme.colors.base0D}";
          magenta = "#${colorscheme.colors.base0E}";
          cyan = "#${colorscheme.colors.base0C}";
          white = "#${colorscheme.colors.base05}";
        };
        bright = {
          black = "#${colorscheme.colors.base03}";
          red = "#${colorscheme.colors.base08}";
          green = "#${colorscheme.colors.base0B}";
          yellow = "#${colorscheme.colors.base0A}";
          blue = "#${colorscheme.colors.base0D}";
          magenta = "#${colorscheme.colors.base0E}";
          cyan = "#${colorscheme.colors.base07}";
          white = "#${colorscheme.colors.base06}";
        };
      };
      window = {
        dimensions = {
          x = 80;
          y = 24;
        };
        decorations = "none";
        padding = {
          x = 10;
          y = 10;
        };
      };
      selection.save_to_clipboard = true;
      cursor.style = {
        shape = "Block";
        blinking = "Off";
      };
      env."LC_ALL" = "en_US.UTF-8";
    };
  };
}
