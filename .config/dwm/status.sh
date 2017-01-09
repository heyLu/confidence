#!/bin/sh

status=""

# network
#status="📡 $(nmcli --terse --fields STATE -c no g status)"
#status="📡 $(nmcli --terse --colors no --fields name,type connection show --active | grep -v ':bridge$' | sed 's/:[-a-z0-9]*$//' | head -n1)"

# battery
charge_path="/sys/class/power_supply"
charge_full=`cat $charge_path/BAT0/energy_full`
charge_now=`cat $charge_path/BAT0/energy_now`
charge_rate=$(($charge_now * 100 / $charge_full ))
charge_icon=" "
if [ "$(cat $charge_path/AC/online)" -eq "1" ]; then
	charge_icon="⚡"
fi
status="$status   $charge_icon $charge_rate%"

# date
status="$status   🕐 $(date '+%a %b %_d %H:%M')"

echo "$status"
