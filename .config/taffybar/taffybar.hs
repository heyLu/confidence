import System.Taffybar
import System.Taffybar.Battery
import System.Taffybar.Systray
import System.Taffybar.XMonadLog
import System.Taffybar.SimpleClock
import System.Taffybar.Widgets.PollingGraph
import System.Information.CPU

cpuCallback = do
    (_, systemLoad, totalLoad) <- cpuLoad
    return [ totalLoad, systemLoad ]

main = do
    let cpuCfg = defaultGraphConfig {
            graphDataColors = [(0, 1, 0, 1), (1, 0, 1, 0.5)]
        }
        clock = textClockNew Nothing "<span fgcolor='orange'>%a %b %_d %H:%M</span>" 1
        log = xmonadLogNew
        tray = systrayNew
        cpu = pollingGraphNew cpuCfg 3 cpuCallback
        battery = textBatteryNew "%d%%" 30
    defaultTaffybar defaultTaffybarConfig {
        barHeight = 15,
        startWidgets = [log],
        endWidgets = [tray, clock, battery, cpu]
    }
