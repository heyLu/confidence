#!/bin/bash

# Warn if the battery status is lower than 10%

charge_path="/sys/class/power_supply"
charge_full=`cat $charge_path/BAT0/energy_full`
charge_now=`cat $charge_path/BAT0/energy_now`
charge_rate=$(($charge_now * 100 / $charge_full ))

online=`cat $charge_path/AC/online`

if [ "$online" = "0" -a $charge_rate -lt 10 ]; then
	DISPLAY=:0 zenity --error --text "Whoopey: You're low on energy (only $charge_rate% left)!"
fi
