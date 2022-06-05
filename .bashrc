
######################################
#
# Termux bash.bashrc
# by brainf+ck
#
# Last modified: 2022/05/01
#
######################################

#### Handles nonexistent commands ####

# If user has entered command which invokes non-available
# utility, command-not-found will give a package suggestions.
if [ -x $PREFIX/libexec/termux/command-not-found ]; then
	command_not_found_handle() {
		$PREFIX/libexec/termux/command-not-found "$1"
	}
fi

#### History settings ################

# append to the history file, don't overwrite it
shopt -s histappend

# load results of history substitution into the readline editing buffer
shopt -s histverify

# don't put duplicate lines or lines starting with space in the history
HISTCONTROL=ignoreboth

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

#### Autocompletion ##################

# cycle through all matches with 'TAB' key
bind 'TAB:menu-complete'

# necessary for programmable completion
shopt -s extglob

# cd when entering just a path
shopt -s autocd

#### Prompt ##########################
IP=`ip a | \grep 'inet.*wlan' | awk '{print $2}' | cut -d/ -f1`
PS1='\# \t \[\033[0;32m\]\[\033[1;34m\]\u@'$IP'\[\033[0;32m\]:\[\033[0;1m\]\w\[\033[0;32m\]\[\033[0;32m\]\[\033[1;34m\]\n\$ \[\033[0m\]'


#### Aliases #########################

# enable color support of ls, grep and ip, also add handy aliases
if [[ -x /usr/bin/dircolors ]]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias diff='diff --color=auto'
    alias ip='ip -color'
fi

# common commands
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias lm='ls | more'
alias ll='ls -lFh'
alias la='ls -alFh --group-directories-first'
alias l1='ls -1F --group-directories-first'
alias l1m='ls -1F --group-directories-first | more'
alias lh='ls -ld .??*'
alias lsn='ls | cat -n'
alias mkdir='mkdir -p -v'
alias cp='cp --preserve=all'
alias cpv='cp --preserve=all -v'
alias cpr='cp --preserve=all -R'
alias cpp='rsync -ahW --info=progress2'
alias cs='printf "\033c"'
alias q='exit'

# memory/cpu
alias free='free -mt'
alias ps='ps auxf'
alias ht='htop'

sshdc=$(ps aux | grep sshd | wc -l)
if [[ $sshdc -lt 1 ]];then
    sshd -p 2222
    echo 'start sshd at 2222'
fi
