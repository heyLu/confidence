# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored
#zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}' 'r:|[._-/]=** r:|=**'
zstyle ':completion:*' matcher-list 'r:|[._-]=** r:|=**'
zstyle :compinstall filename '/home/lu/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install

autoload -Uz bracketed-paste-magic
zle -N bracketed-paste bracketed-paste-magic

autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt -o sharehistory
setopt autocd extendedglob
# End of lines configured by zsh-newuser-install

function repo_char {
	$HOME/.bin/up .hg >/dev/null 2> /dev/null && echo '☿' && return
	$HOME/.bin/up .git > /dev/null 2> /dev/null && echo "±" && return
	echo "∅"
}

function repo_branch {
	if $HOME/.bin/up .hg > /dev/null 2> /dev/null; then
		echo "%{$fg[green]%}$(cat `$HOME/.bin/up .hg`/.hg/branch)%{$reset_color%}"
	elif git branch > /dev/null 2> /dev/null; then
		echo "%{$fg[green]%}$(git branch --no-color | sed -En 's/^\* (.*)/\1/p')%{$reset_color%}"
	fi
}

autoload colors && colors
function precmd {
	echo -ne "\033]0;\007"
	user="%{$fg[red]%}%n%{$reset_color%}"
	dir="%{$fg[cyan]%}%~%{$reset_color%}"
	lastcmd="$history[$(($HISTCMD-1))]"
	lastcmd_witherror="%(?!$lastcmd!%B$lastcmd%b)"
	if [ -n "$SSH_CONNECTION" ]; then
		server="@`echo $SSH_CONNECTION | cut -d' ' -f3`"
	fi
	PROMPT="$user$server in $dir@$(repo_branch) $lastcmd_witherror
$(repo_char) $ "
	RPROMPT="%D{%Y-%m-%d} %{$fg[red]%}%t%{$reset_color%}"
}

bindkey -e
bindkey $terminfo[kend]  end-of-line
bindkey $terminfo[khome] beginning-of-line
bindkey $terminfo[kdch1] delete-char
bindkey  history-incremental-search-backward

source ~/.env
source ~/.aliases

# OPAM configuration
. /home/lu/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
