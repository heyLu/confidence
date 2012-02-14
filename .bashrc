# shortcuts
alias _ls='ls --color=auto'
alias ls='~/t/ls--/ls++'
alias v='~/t/sh/v/v'
alias here='find . -type f -name '
# Find targets in a Makefile: targets <makefile>
alias targets='grep -E "^[-A-Za-z0-9]+:"'

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
todo() { if [ $# = 0 ]; then cat $TODO; else echo " * $@" >> $TODO; fi }
todone() { sed -n "/$*/p" $TODO >> $TODO.done; sed -i "/$*/d" $TODO; }

infoq() {
	ipadUA='Mozilla/5.0 (iPad; U; CPU OS 3_2 like Mac OS X; en-us) AppleWebKit/531.21.10 (KHTML, like Gecko) Version/4.0.4 Mobile/7B334b Safari/531.21.10'
	curl --silent --header "User-Agent: $ipadUA" $1 | grep '<source' | sed 's/^[ ]*.*="\(.*\)".*$/\1/'
}

ds() {
	du -ch $@ | tail -n1
}

. $HOME/t/sh/z/z.sh

# bash-completion for sudo
complete -cf sudo

PATH=$HOME/.cabal/bin:$HOME/ruby-1.9.4dev/bin:$HOME/erlang-git/bin:$HOME/nodejs/bin:$PATH

# Make some programs friendlier
EDITOR=vim
# aka LESS=XFR
LESS="--no-init --quit-if-one-screen --RAW-CONTROL-CHARS"

HISTIGNORE="&:ls:exit"
HISTCONTROL=ignoredups:erasedups

#export PS1="\u [$(t | wc -l | sed -e's/ *//')] \w ($(git branch | sed 's/^\* //'))$ "
export PS1='\u \w$ '
export PROMPT_COMMAND='history -a; history -c; history -r;'

export EDITOR LESS
export HISTIGNORE HISTCONTROL
export VIMCLOJURE_SERVER_JAR="$HOME/t/vim/clojure/server/server-2.3.1.jar"
export TODO="$HOME/d/todo"
