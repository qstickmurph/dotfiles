#
# ~/.bashrc
#
#
export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/ssh-agent.socket"

# If not running interactively, don't do anything
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

export EDITOR='nvim'

S1='[\u@\h \W]\$ '


