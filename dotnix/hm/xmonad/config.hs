import XMonad

import XMonad.Util.EZConfig
import XMonad.Util.Ungrab

import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.DynamicLog

main :: IO ()
main = xmonad . ewmh =<< xmobar myConfig

myConfig = def
    { modMask = mod4Mask
    }
  `additionalKeysP`
    [ ("M-S-<Return>" , spawn "alacritty --command zsh" )
    , ("M-S-f"        , spawn "firefox"   )
    ]
