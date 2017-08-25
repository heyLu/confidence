#!/bin/bash

xsetroot -cursor_name left_ptr
# Disable turning the screen off to save power
xset -dpms; xset s off

#feh -bg-scale /usr/share/themes/Adwaita/backgrounds/stripes.jpg

# Use de layout when Alt+Gr is pressed
setxkbmap -option grp:switch us,de

eval `dbus-launch --auto-syntax`
#start-pulseaudio-x11
#pactl set-sink-volume 0 1.0
#nm-applet&
#conky&
udiskie --smart-tray --no-notify &

#xmodmap ~/.swap-esc-capslock
synclient TouchpadOff=1

if which xbanish &> /dev/null; then
	xbanish&
fi

#taffybar&

redshift&

#eval $(ssh-agent -s)
eval $(gnome-keyring-daemon --replace)
export SSH_AUTH_SOCK

#xrandr --output LVDS1 --off --output DP1 --mode 1920x1080

while xsetroot -name "$(~/.config/dwm/status.sh)"; do
	sleep 1
done&

exec ~/t/suckless/dwm/dwm
#exec xmonad
#exec gnome-session
