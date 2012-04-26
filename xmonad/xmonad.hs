import XMonad
import XMonad.Util.EZConfig
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks

import XMonad.Layout.ResizableTile
import XMonad.Layout.Tabbed
import XMonad.Layout.ThreeColumns
import XMonad.Layout.MosaicAlt
-- import XMonad.Layout.Spiral
import XMonad.Layout.Maximize
import XMonad.Layout.Minimize
import XMonad.Actions.CycleWS

import qualified Data.Map as M


mylayoutHook = minimize $ maximize $ ResizableTall 1 (3/100) (1/2) []
	||| ThreeCol 1 (3/100) (1/2)
	||| MosaicAlt M.empty
	||| simpleTabbed ||| Full
--	||| spiral (16/9)


main = xmonad =<< xmobar (defaultConfig
	{ modMask = mod1Mask
--	, terminal = "lxterminal"
--	, terminal = "sakura"
	, terminal = "urxvt"
	, layoutHook = avoidStruts mylayoutHook
	, manageHook = manageHook defaultConfig <+> manageDocks
	, borderWidth = 1
	} `additionalKeysP`
	[ ("M-p", spawn "dmenu_run")
	, ("M-<R>", nextWS)
	, ("M-<L>", prevWS)
	, ("M-j", sendMessage MirrorShrink)
	, ("M-k", sendMessage MirrorExpand)
	, ("M-m", withFocused (sendMessage . maximizeRestore))
	--, ("M-n", withFocused (sendMessage . MinimizeWin))
	--, ("M-S-n", sendMessage RestoreNextMinimizedWin)
	])
