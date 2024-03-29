# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1=': `basename \w`#$(git w 2> /dev/null || git rev-parse --short HEAD 2> /dev/null); '
    PS2='$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias lsl='ls -lt | head'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

#Modules
test -f /opt/tcl/init/bash && . /opt/tcl/init/bash

#Shut up
#xset b off

#Dalton
# . ~/.daltonrc
export scripting=/home/olav/Dropbox/Course/KCSE/Scripting
# export PS1="$ "
export AFS=/afs/pdc.kth.se/home/v/vahtras
#no color
unalias ls

### Added by the Heroku Toolbelt
export PATH="$HOME/.local/bin:$PATH"

#virtualenvwrapper
#export WORKON_HOME=$HOME/.virtualenvs
#test -f /usr/local/bin/virtualenvwrapper.sh && source /usr/local/bin/virtualenvwrapper.sh

#
export PIPENV_VENV_IN_PROJECT=1
export PATH=${HOME}/tools/vim/bin:$PATH
#
# scons
#
export SCONSFLAGS="-Q"


parse_git_branch() {
    branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
    test -n "$branch" && echo "$branch"
}
parse_venv() {
    test -n "$VIRTUAL_ENV" && echo "($(basename $VIRTUAL_ENV)) "
}
reverse() {
echo "[7m$*[00m"
}
red() {
echo "[31m$*[00m"
}
green() {
echo [32m$*[00m
}
blue() {
echo "[34m$*[00m"
}
magenta() {
echo "[35m$*[00m"
}
cyan() {
echo "[36m$*[00m"
}
mg() { #magenta-green
echo "[35m[42m$*[00m"
}
cm() { #cyan-magenta
echo "[36m[45m$*[00m"
}

#PS1='$(reverse $(cyan "📂\w" ))$(cm )$(reverse $(magenta $(parse_git_branch)))$(mg )$(reverse $(green $(parse_venv)))$(green )\n\$ '
PS1='$(reverse $(cyan $(parse_venv) ))$(cm )$(reverse $(magenta $(parse_git_branch)))$(mg )$(reverse $(green "\u@\h:📂\w"))$(green )\n\$ '
export VIRTUAL_ENV_DISABLE_PROMPT=0

# . ~/.pyenvrc
# export PYENV_ROOT=$HOME/.pyenv
# export PATH=$PYENV_ROOT/bin:$PATH
# if command -v pyenv 1>/dev/null 2>&1; then
#     eval "$(pyenv init -)"
# fi

#  ♻️  📂  ♻
#
# Open new shell in virtual environment

export GTESTROOT=/opt/googletest/googletest
export GTESTLIB=$GTESTROOT/lib/libgtest.a
export OMP_NUM_THREADS=12
# export MKLROOT=/opt/intel/mkl

export PATH=$PATH:.

# direnv for project-dependent environment variables
eval "$(direnv hook bash)"

#starship
eval "$(starship init bash)"
function set_win_title(){
    echo -ne "\033]0; $(basename "$PWD") \007"
}
starship_precmd_user_func="set_win_title"

