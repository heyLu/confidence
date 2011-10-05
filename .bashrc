# shortcuts
alias ls='ls --color=auto'

ds() {
	du -h $1 | tail -n1
}

# bash-completion for sudo
complete -cf sudo

PATH=$HOME/ruby-1.9.4dev/bin:$HOME/erlang-git/bin:$HOME/nodejs/bin:$PATH

# Make some programs friendlier
EDITOR=vim
LESS=RSX

export EDITOR LESS
