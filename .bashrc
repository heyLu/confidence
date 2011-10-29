# shortcuts
alias ls='ls --color=auto'
alias v='~/t/sh/v/v'
alias here='find . -type f -name '
alias targets='grep -E "^[-A-Za-z0-9]+:"'

## tasklists
alias t='python ~/t/sh/t/t.py --task-dir ~/.tasks --list task'
alias u='python ~/t/sh/t/t.py --task-dir ~/.tasks --list uni'
alias p='python ~/t/sh/t/t.py --task-dir $PWD/.tasks --list task'

ds() {
	du -h $1 | tail -n1
}

. $HOME/t/sh/z/z.sh

# bash-completion for sudo
complete -cf sudo

PATH=$HOME/.cabal/bin:$HOME/ruby-1.9.4dev/bin:$HOME/erlang-git/bin:$HOME/nodejs/bin:$PATH

# Make some programs friendlier
EDITOR=vim
LESS=RSX

HISTIGNORE="&:ls:exit"
HISTCONTROL=ignoredups:erasedups

#export PS1="\u [$(t | wc -l | sed -e's/ *//')] \w ($(git branch | sed 's/^\* //'))$ "
export PS1='\u \w$ '
export PROMPT_COMMAND='history -a; history -c; history -r;'

export EDITOR LESS
export HISTIGNORE HISTCONTROL
