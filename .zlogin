export WINEDLLOVERRIDES="mscoree=d;mshtml=d"

# If running from tty1 start sway
if [ "$(tty)" = "/dev/tty1" ]; then
	export QT_QPA_PLATFORM=wayland
	export _JAVA_AWT_WM_NONREPARENTING=1

	export MOZ_ENABLE_WAYLAND=1

	# webrtc screen sharing
	export XDG_CURRENT_DESKTOP=niri

	export MANGOHUD=1

	#eval $(ssh-agent)
	unset SSH_AGENT_PID
	export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"

	#mv -f ~/.sway.log ~/.sway.log.1
	#exec dbus-run-session sway &> ~/.sway.log
	#exec dbus-run-session niri
	systemctl --user start niri
fi

systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
