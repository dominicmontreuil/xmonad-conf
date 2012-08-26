import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import Graphics.X11.ExtraTypes.XF86
import XMonad.Util.EZConfig(additionalKeys)
import System.IO


myManageHook = composeAll
    [ className =? "Gimp"               --> doFloat
    , className =? "VirtualBox"         --> doFloat
    , className =? "Teamviewer"         --> doFloat
    , className =? "Computers & Contacts"   --> doFloat
    , className =? "Remmina"            --> doFloat
    ]

main = do
    xmproc <- spawnPipe "/usr/bin/xmobar /home/mond/.xmobarrc"
    xmonad $ defaultConfig
        { manageHook = manageDocks <+> myManageHook <+> manageHook defaultConfig
            , layoutHook = avoidStruts  $  layoutHook defaultConfig
            , logHook = dynamicLogWithPP xmobarPP
                { ppOutput = hPutStrLn xmproc
                , ppTitle = xmobarColor "green" "" . shorten 50
                }
                , modMask = mod4Mask     -- Rebind Mod to the Windows key
        } `additionalKeys`
        [ ((mod4Mask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock")
        , ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s")
        , ((0, xK_Print), spawn "scrot")
        , ((0, xF86XK_AudioLowerVolume), spawn "amixer set Master 3%-") -- decrease volume  
        , ((0, xF86XK_AudioRaiseVolume), spawn "amixer set Master 3%+") -- increase volume  
        , ((0, xF86XK_AudioMute), spawn "amixer set Master toggle") -- mute volume  
        ]

