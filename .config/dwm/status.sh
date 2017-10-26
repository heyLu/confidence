#!/bin/sh

status=""

# network
#status="📡 $(nmcli --terse --fields STATE -c no g status)"
network="$(nmcli --terse --colors no --fields name,type connection show --active | grep -v ':bridge$' | sed 's/:[-a-z0-9]*$//' | head -n1)"
status="📡 $network"
if [ "$network" = "" ]; then
	status="📯"
fi
#status="📡 $(nmcli -t -f active,ssid dev wifi | sort -r | uniq)"

# battery
charge_path="/sys/class/power_supply"
charge_full=`cat $charge_path/BAT0/energy_full`
charge_now=`cat $charge_path/BAT0/energy_now`
if [ -z "$charge_full" -o -z "$charge_now" ]; then
	charge_rate="?"
else
	charge_rate=$(($charge_now * 100 / $charge_full ))
fi
charge_icon=" "
if [ "$(cat $charge_path/AC/online)" -eq "1" ]; then
	charge_icon="⚡"
fi
status="$status   $charge_icon $charge_rate%"

# date
status="$status   🕐 $(date '+%a %b %_d %H:%M')"

echo "$status"
