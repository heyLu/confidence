#!/bin/bash

xsetroot -cursor_name left_ptr

xrdb -merge ~/.Xresources
#feh -bg-scale /usr/share/themes/Adwaita/backgrounds/stripes.jpg

start-pulseaudio-x11
pactl set-sink-volume 0 1.0
nm-applet&
#conky&

#xmodmap ~/.swap-esc-capslock
synclient TouchpadOff=1

exec awesome
#exec xmonad
#exec gnome-session
