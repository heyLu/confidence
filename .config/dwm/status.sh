#!/bin/sh

status=""

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
