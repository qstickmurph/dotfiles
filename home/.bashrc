#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

export EDITOR='nvim'

S1='[\u@\h \W]\$ '

#neofetch
