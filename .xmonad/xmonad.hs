import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks (manageDocks, avoidStruts)
import XMonad.Hooks.ManageHelpers
import XMonad.Layout.Tabbed (simpleTabbed)
import XMonad.Util.Run (spawnPipe)
import XMonad.Util.EZConfig (additionalKeys)
import System.IO (hPutStrLn)
import Data.IORef.MonadIO (newIORef, readIORef, modifyIORef)

import Control.Monad (when)
import Data.Monoid (All (All))
import qualified XMonad.StackSet as W

-- My XMonad config (right now it's mostly copied from elsewhere...
--
-- Whishes:
--  * Some kind of launcher
--  * Logging framework (like reading urls from Firefox and the like)

main = do
    kbMap <- newIORef "us"
    xmobar <- spawnPipe "xmobar"
    xmonad $ defaultConfig {
        modMask  = mod4Mask,
        terminal = "urxvt",
        -- Ignore docks (via some WM_* attribute?)
        manageHook = composeAll [
                        manageDocks,
                        -- Allow fullscreen
                        composeOne [ isFullscreen -?> doFullFloat ]
                     ] <+> manageHook defaultConfig,
        -- Don't overwrite the section used by docks
        layoutHook = avoidStruts $ layoutHook defaultConfig ||| simpleTabbed,
        logHook = dynamicLogWithPP xmobarPP {
            ppOutput = hPutStrLn xmobar,
            ppTitle = xmobarColor "green" ""
        },
        handleEventHook = evHook
     } `additionalKeys` [
        ((mod4Mask, xK_l), changeKbMap kbMap)
     ]
  where changeKbMap kbMap = do
          kb <- readIORef kbMap
          let switchLang cur = if cur == "us" then "de" else "us"
          spawn $ "setxkbmap " ++ switchLang kb
          modifyIORef kbMap switchLang

evHook :: Event -> X All
evHook (ClientMessageEvent _ _ _ dpy win typ dat) = do
    state <- getAtom "_NET_WM_STATE"
    fullsc <- getAtom "_NET_WM_STATE_FULLSCREEN"
    isFull <- runQuery isFullscreen win

    let remove = 0
        add = 1
        toggle = 2

        ptype = 4

        action = head dat

    when (typ == state && (fromIntegral fullsc) `elem` tail dat) $ do
        when (action == add || (action == toggle && not isFull)) $ do
            io $ changeProperty32 dpy win state ptype propModeReplace [fromIntegral fullsc]
            fullFloat win
        when (head dat == remove || (action == toggle && isFull)) $ do
            io $ changeProperty32 dpy win state ptype propModeReplace []
            tileWin win

    return $ All False

evHook _ = return $ All True

fullFloat, tileWin :: Window -> X () 
fullFloat w = windows $ W.float w (W.RationalRect 0 0 1 1)
tileWin   w = windows $ W.sink w
