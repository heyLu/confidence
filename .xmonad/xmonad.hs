import XMonad
import XMonad.Actions.SpawnOn (manageSpawn, spawnHere)
import System.Taffybar.Hooks.PagerHints (pagerHints)
import XMonad.Hooks.ManageDocks (ToggleStruts(..), manageDocks, avoidStruts)
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Hooks.EwmhDesktops (ewmh)
import XMonad.Layout.NoBorders (smartBorders)
import XMonad.Layout.Fullscreen (fullscreenEventHook, fullscreenManageHook)
import XMonad.Util.Run (spawnPipe)
import XMonad.Util.EZConfig (additionalKeys)
import Graphics.X11.ExtraTypes.XF86
import qualified XMonad.StackSet as W

import System.IO (hPutStrLn)
import Data.IORef.MonadIO (newIORef, readIORef, modifyIORef)
import Control.Monad (when)
import Data.Monoid (All (All))

-- My XMonad config (right now it's mostly copied from elsewhere...
--
-- Whishes:
--  * Some kind of launcher
--  * Logging framework (like reading urls from Firefox and the like)

(??) :: Query a -> (a -> Bool) -> Query Bool
(??) = flip fmap

main = do
    xmonad $ ewmh $ pagerHints $ defaultConfig {
        modMask  = mod4Mask,
        terminal = "sakura",
        startupHook = setWMName "LG3D",
        -- Ignore docks (via some WM_* attribute?)
        manageHook = composeAll [
                        className ?? (\cn -> any (cn ==) ["Skype", "Pidgin", "Geary"]) --> doF (W.shift "3"),
                        className =? "Exe" --> doFullFloat,
                        className =? "Zenity" --> doFloat,
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

        ((0, xF86XK_AudioMute), spawn "amixer set Master toggle"),
        ((0, xF86XK_AudioLowerVolume), spawn "amixer set Master 5%-"),
        ((0, xF86XK_AudioRaiseVolume), spawn "amixer set Master 5%+"),
        ((mod4Mask .|. shiftMask, xK_m), spawnHere "quodlibet"),

        ((mod4Mask .|. shiftMask, xK_Tab), spawn "xkbswap"),
        ((mod4Mask .|. shiftMask, xK_l), spawn "ssh-add -D && slock"),

        ((0, xK_Print), spawn "scrot -e 'mv $f ~/m/pictures/ 2>/dev/null'"),

        ((mod4Mask, xK_f), sendMessage ToggleStruts),
        ((mod4Mask, xK_q), restart "xmonad" True)
     ]
