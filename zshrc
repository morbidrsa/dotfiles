# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory extendedglob
unsetopt beep
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/jt/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

alias emacs="emacs -nw"
export EDITOR="emacs -nw"
export PATH=$PATH:/usr/sbin/:/sbin

# Autocorrect
#setopt correctall

# Allow comments on command line
setopt interactivecomments

setopt AUTO_PUSHD


# PROMPT related stuff
autoload -U colors && colors
setopt prompt_subst
if [ -n $HOME/.git-prompt ]; then
    source $HOME/.git-prompt
    local gitval='%{$fg_bold[red]%}$(__git_ps1 "(%s)")'

    PROMPT="%{$fg[green]%}%n%{$reset_color%}@%{$fg[blue]%}%m:%{$fg_no_bold[yellow]%}%1~ ${gitval}%{$reset_color%}%# "
else
    PROMPT="%{$fg[green]%}%n%{$reset_color%}@%{$fg[blue]%}%m:%{$fg_no_bold[yellow]%}%1~ %{$reset_color%}%# "
fi
