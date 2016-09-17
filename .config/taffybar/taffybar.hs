import Data.IORef (newIORef)

import System.Taffybar
import System.Taffybar.Battery (textBatteryNew)
import System.Taffybar.Systray
import System.Taffybar.TaffyPager
import System.Taffybar.SimpleClock
import System.Taffybar.Widgets.PollingGraph
import System.Taffybar.Widgets.PollingLabel
import System.Information.Battery (batteryContextsNew)
import System.Information.CPU
import System.Information.Memory (parseMeminfo, memoryUsedRatio)
import Graphics.UI.Gtk (widgetShowAll)

cpuCallback = do
    (_, systemLoad, totalLoad) <- cpuLoad
    return [totalLoad, systemLoad]

formatMeminfo m = "Mem: " ++ memPercentage ++ "%"
    where memPercentage = show . truncate . ((*) 100) $ memoryUsedRatio m

textMemoryNew intervalSeconds = do
    memLabel <- pollingLabelNew "" intervalSeconds (parseMeminfo >>= return . formatMeminfo)
    widgetShowAll memLabel
    return memLabel

main = do
    cs <- batteryContextsNew
    rs <- sequence $ fmap newIORef cs
    let cpuCfg = defaultGraphConfig {
            graphDataColors = [(0, 1, 0, 1), (1, 0, 1, 0.5)]
        }
        clock = textClockNew Nothing "<span fgcolor='orange'>%a %b %_d %H:%M</span>" 1
        log = taffyPagerNew defaultPagerConfig
        tray = systrayNew
        cpu = pollingGraphNew cpuCfg 3 cpuCallback
        battery = textBatteryNew rs "Bat: $percentage$%" 30
        --battery = batteryBarNew defaultBatteryConfig 30
        memory = textMemoryNew 3
    defaultTaffybar defaultTaffybarConfig {
        barHeight = 15,
        startWidgets = [log],
        endWidgets = [tray, clock, memory, battery, cpu]
    }
