if [ -f /etc/bashrc ]; then
    . /etc/bashrc;
fi

if [ -f /etc/bash.bashrc ]; then
    . /etc/bash.bashrc;
fi

if [ -f /etc/bash_completion ]; then
	. /etc/bash_completion;
fi

if [ -f $HOME/.git-prompt.sh ]; then
	. $HOME/.git-prompt.sh;
fi

if [ $TERM = "rxvt-unicode-256color" ]; then
	export TERM="xterm-color"
fi

case "$TERM" in
    xterm*|rxvt*)
	eval `dircolors -b`
	PS1='\[\e[1;32m\]\u@\h:\[\e[1;34m\]\W\[\e[1;31m\]$(__git_ps1 " (%s)")\[\e[1;32m\]\$\[\e[0m\] '
	alias grep="grep --color=auto"
	alias ls="ls --color=auto"
	;;
    *)
	;;
esac

function ssh_add_keys {
	ssh-add -l 2>&1 > /dev/null
	
	if [ $? -gt 0 ]; then
		ssh-add
	fi
}

if [ $SSH_AGENT_PID ]; then
	ssh_add_keys
fi

PATH=$PATH:.
EDITOR=emacs
export PATH EDITOR

alias ll="ls -lh"
alias gprn="grep -Prn"
alias ssh="ssh -AX"
alias mtr="mtr --curses"
alias pacman="pacman --color=auto"
# Let sudo preserve aliases
alias sudo="sudo "
