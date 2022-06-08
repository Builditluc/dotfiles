{ config, pkgs, ... }:
{
  programs.xmobar = {
    enable = true;
    extraConfig = ''
      Config { font            = "xft:Ubuntu:weight=bold:pixelsize=11:antialias=true:hinting=true"
       , bgColor      = "#2E3440"
       , fgColor      = "#D8DEE9"
       -- Position TopSize and BottomSize take 3 arguments:
       --   an alignment parameter (L/R/C) for Left, Right or Center.
       --   an integer for the percentage width, so 100 would be 100%.
       --   an integer for the minimum pixel height for xmobar, so 24 would force a height of at least 24 pixels.
       --   NOTE: The height should be the same as the trayer (system tray) height.
       , position       = TopSize L 100 24
       , lowerOnStart = True
       , hideOnStart  = False
       , allDesktops  = True
       , persistent   = True
       , commands = [
                        -- Cpu usage in percent
                    Run Cpu ["-t", "cpu: (<total>%)","-H","50","--high","red"] 20
                        -- Ram used number and percent
                    , Run Memory ["-t", "mem: <used>M (<usedratio>%)"] 20
                        -- Disk space free
                    , Run DiskU [("/", "hdd: <free> free")] [] 60
                        -- Uptime
                    , Run Uptime ["-t", "uptime: <days>d <hours>h"] 360
                        -- Battery
                    , Run BatteryP ["BAT0"] ["-t", "<acstatus><watts> (<left>%)"] 360
                        -- Time and date
                    , Run Date "%d/%m/%y %H:%M" "date" 50
                    ]
       , sepChar = "%"
       , alignSep = "}{"
       , template = " }{ <box type=Bottom width=2 mb=2 color=#A3BE8C><fc=#A3BE8C><action=`alacritty -e htop`>%cpu%</action></fc></box>    <box type=Bottom width=2 mb=2 color=#81A1C1><fc=#81A1C1><action=`alacritty -e htop`>%memory%</action></fc></box>    <box type=Bottom width=2 mb=2 color=#EBCB8B><fc=#EBCB8B>%disku%</fc></box>    <box type=Bottom width=2 mb=2 color=#BF616A><fc=#BF616A>%battery%</fc></box>    <box type=Bottom width=2 mb=2 color=#A3BE8C><fc=#A3BE8C>%date%</fc></box>"
       }
    '';
  };
}
