# Open files with default application
alias open="xdg-open"

# Kitty SSH wrapper
if test "$TERM" = "xterm-kitty"
    alias ssh="kitten ssh"
end

# ls aliases
alias ll="ls -alF"
alias la="ls -A"
alias l="ls -CF"

# Enable color support for ls/grep
if test -x /usr/bin/dircolors
    if test -r ~/.dircolors
        eval (dircolors -c ~/.dircolors)
    else
        eval (dircolors -c)
    end

    alias ls="ls --color=auto"
    alias dir="dir --color=auto"
    alias vdir="vdir --color=auto"

    alias grep="grep --color=auto"
    alias fgrep="fgrep --color=auto"
    alias egrep="egrep --color=auto"
end

# Neovim shortcuts
alias vim="nvim"
alias nv="nvim"
alias neorg="nvim ~/Documents/notes/index.org"
