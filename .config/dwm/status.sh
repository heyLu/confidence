#!/bin/sh

status=""

# battery
charge_path="/sys/class/power_supply"
charge_full=`cat $charge_path/BAT0/energy_full`
charge_now=`cat $charge_path/BAT0/energy_now`
charge_rate=$(($charge_now * 100 / $charge_full ))
status="$status$charge_rate%"

# date
status="$status   $(date '+%a %b %_d %H:%M')"

echo "$status"
