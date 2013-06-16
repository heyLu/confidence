import XMonad
import XMonad.Actions.SpawnOn (manageSpawn, spawnHere)
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks (manageDocks, avoidStruts)
import XMonad.Hooks.ManageHelpers
import XMonad.Layout.NoBorders (smartBorders)
import XMonad.Layout.Fullscreen (fullscreenEventHook, fullscreenManageHook)
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

(??) :: Query a -> (a -> Bool) -> Query Bool
q ?? p = fmap p q

main = do
    kbMap <- newIORef "us"
    xmonad $ defaultConfig {
        modMask  = mod4Mask,
        terminal = "sakura",
        -- Ignore docks (via some WM_* attribute?)
        manageHook = composeAll [
                        className ?? (\cn -> any (cn ==) ["Skype", "Pidgin", "Geary"]) --> doF (W.shift "3"),
                        manageSpawn,
                        manageDocks,
                        fullscreenManageHook
                     ] <+> manageHook defaultConfig,
        -- Don't overwrite the section used by docks
        layoutHook = avoidStruts $ smartBorders $ layoutHook defaultConfig,
        handleEventHook = fullscreenEventHook
     } `additionalKeys` [
        ((mod4Mask, xK_b), spawnHere "chromium --allow-file-access-from-files"),
        ((mod4Mask .|. shiftMask, xK_b), spawnHere "chromium --incognito --allow-file-access-from-files"),

        ((mod4Mask .|. shiftMask, xK_Tab), changeKbMap kbMap),
        ((mod4Mask .|. shiftMask, xK_l), spawn "slock"),

        ((mod4Mask, xK_q), restart "xmonad" True)
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
