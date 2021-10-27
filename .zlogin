export WINEDLLOVERRIDES="mscoree=d;mshtml=d"

# If running from tty1 start sway
if [ "$(tty)" = "/dev/tty1" ]; then
	export QT_QPA_PLATFORM=wayland
	export _JAVA_AWT_WM_NONREPARENTING=1

	export MOZ_ENABLE_WAYLAND=1

	# webrtc screen sharing
	export XDG_CURRENT_DESKTOP=sway

	export MANGOHUD=1

	mv -f ~/.sway.log ~/.sway.log.1
	exec sway > ~/.sway.log
fi
