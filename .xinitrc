#!/bin/bash

xsetroot -cursor_name left_ptr

xrdb -merge ~/.Xresources
#feh -bg-scale /usr/share/themes/Adwaita/backgrounds/stripes.jpg

eval `dbus-launch --auto-syntax`
start-pulseaudio-x11
pactl set-sink-volume 0 1.0
nm-applet&
#conky&

#xmodmap ~/.swap-esc-capslock
synclient TouchpadOff=1

taffybar&

#exec awesome
exec xmonad
#exec gnome-session
