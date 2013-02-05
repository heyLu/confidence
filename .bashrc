# shortcuts
alias ls='/bin/ls --group-directories-first --color=auto'
alias v='~/t/sh/v/v'
alias here='find . -type f -name '
# Find targets in a Makefile: targets <makefile>
alias targets='grep -E "^[-A-Za-z0-9]+:"'
alias diff='diff -u'

## archlinux
alias _ps="pacman -Ss"
alias _pi="sudo pacman -S"
alias _pu="sudo pacman -Sy"
alias _pr="sudo pacman -Rs"

## tasklists
alias t='python ~/t/sh/t/t.py --task-dir ~/.tasks --list task'
alias u='python ~/t/sh/t/t.py --task-dir ~/.tasks --list uni'
alias p='python ~/t/sh/t/t.py --task-dir $PWD/.tasks --list task'

# http://blog.jerodsanto.net/2010/12/minimally-awesome-todos/
todo() { if [ $# = 0 ]; then cat $TODO; else echo " * $@ `date --rfc-3339=seconds`," >> $TODO; fi }
todone() { sed -n "/$*/s|$| `date --rfc-3339=seconds`|p" $TODO >> $TODO.done; sed -i "/$*/d" $TODO; }

infoq() {
	ipadUA='Mozilla/5.0 (iPad; U; CPU OS 3_2 like Mac OS X; en-us) AppleWebKit/531.21.10 (KHTML, like Gecko) Version/4.0.4 Mobile/7B334b Safari/531.21.10'
	curl --silent --header "User-Agent: $ipadUA" $1 | grep '<source' | sed 's/^[ ]*.*="\(.*\)".*$/\1/'
}

ds() { du -ch $@ | tail -n1; }

. $HOME/t/sh/z/z.sh

# bash-completion for sudo
complete -cf sudo

. $HOME/.env
