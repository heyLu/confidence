#!/bin/bash

xsetroot -cursor_name left_ptr

xrdb -merge ~/.Xresources
#feh -bg-scale /usr/share/themes/Adwaita/backgrounds/stripes.jpg

start-pulseaudio-x11
conky&
exec xmonad
#exec gnome-session
