
# Default bashrc***********************************************************************
case $- in
    *i*) ;;
      *) return;;
esac

HISTCONTROL=ignoreboth

shopt -s histappend

HISTSIZE=1000
HISTFILESIZE=2000

shopt -s checkwinsize

if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
fi

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
# End of default bashrc****************************************************

# *************************************************************************
#
# Script to print useful system information on login.
#
# Requirements:
#   - 'tput' and 'figlet'
#
# Usage:
#   Append the content of this file to your .bashrc.
#
# Hint for customizations:
#   * You can add any service/deamon you'd like to print its status in the
#     login message to the 'serviceStatus' function below.
#
# Disclamer:
#   * This script developed on Ubuntu 20.04. Bash v5.0-6ubuntu1.2.
#   * Possible bugs (mainly terminal message-colors bugs).
#
# *************************************************************************
# Resources:
#   Symbols https://unicode-table.com/en/sets/arrow-symbols/
#   Bash colors: https://misc.flogisoft.com/bash/tip_colors_and_formatting
# *************************************************************************

OS=$(lsb_release -si)
OS_RELEASE=$(lsb_release -sc)
OS_VERSION=$(grep "VERSION_ID" < /etc/os-release | cut -c 13-17)
KERNEL=$(uname -r)
UPTIME=$(uptime -p | sed 's/up//')
ColorReset='\e[0m'
Red='\033[0;31m'
Green='\033[0;32m'
Yellow='\e[93m'
Blue='\E[1;34m'
Dim='\e[2m'
Bold=$(tput bold)
Normal=$(tput sgr0)


function resourcesInfo() {
    echo -e -n "$Dim[Res-Info]"
    USED_SPACE=$(df -H / |  awk '{print $5 }' | sed -e /^Use/d | sed 's/%//' | cut -d "." -f 1)
    SPACE_VERBOSE=$(df -H / |  awk '{print $5 " "$3" of "$2}' | sed -e /^Use/d)
    # I want to perform arithmetic comparison, bash doesn't work with floating points, hence the 'cut' command.
    MEMORY=$(grep MemAvailable < /proc/meminfo | awk '{print $2/1024}' | cut -d "." -f 1)
    LOAD=$(awk '{print "~5 min=" $2}' < /proc/loadavg)

    echo -e -n "$ColorReset""➜ [$Bold$Dim Load Average$ColorReset$Normal$Yellow$Dim $LOAD $ColorReset "

    if [[ $MEMORY -lt 2048 ]] ; then
        echo -e -n "$ColorReset""➜ $Bold$Dim Free Memory$ColorReset$Normal $Red ◉ $MEMORY$ColorReset$Dim MiB $ColorReset "
    else
        echo -e -n "$ColorReset""➜ $Bold$Dim Free Memory$ColorReset$Normal $Green ◉ $MEMORY$ColorReset$Dim MiB $ColorReset "
    fi

    if [[ $USED_SPACE -gt 75 ]] ; then
        echo -e -n "$ColorReset""➜ $Bold$Dim Disk Usage$ColorReset$Normal $Red ◉ $SPACE_VERBOSE $ColorReset]"
    else
        echo -e -n "$ColorReset""➜ $Bold$Dim Disk Usage$ColorReset$Normal $Green ◉ $SPACE_VERBOSE $ColorReset]"
    fi

}

function LoggedInUsers () {
    # Get logged in users from tty entry:
    echo -e -n "$Dim[Users-In]"
    # (NR>2) tells awk to skip two header lines
    # sort  and  uniq  to remove duplicate users
    # last sed is to trim/prevent printing whitespaces
    TTY_USERS=$(w | awk '(NR>2) { print $1 }' | sort | uniq | sed '/^[[:space:]]*$/d')

    # Using echo here to print mutiline stdout in a single line via flags: -n and -e
    # To handle a multi-user log in situation. More than one IP will be sent out to stdout from the 'w' command.
    # ->> awk explanation: skip two headers, print third column, sort, get unique IPs, trim space lines
    TTY_IP=$(echo -n -e "$(w | awk '(NR>2) { print $3 }' | sort | uniq | sed '/^[[:space:]]*$/d')")

    echo -e -n "$ColorReset""➜ [$Bold$Dim$ColorReset$Normal$Blue $TTY_USERS$ColorReset$Dim from $Blue$TTY_IP$ColorReset ]"
}

function serviceStatus () {
    IS_ACTIVE=$(systemctl is-active "$1")
    IS_UP=$(systemctl show -p SubState --value "$1")
    if [ "$IS_ACTIVE" = "active" ] ; then
    echo -e -n "$ColorReset""➜ [$Bold$Blue $1$ColorReset$Normal $Green ✓$ColorReset$Dim active "

        case $IS_UP in
            "running") echo -e -n "$Green▲$ColorReset$Dim up$Normal$ColorReset ]" ;;
            "dead") echo -e -n "$Red▼$ColorReset$Dim down$ColorReset ]" ;;
            *) echo -e -n "Error loading service" ;;
        esac

    elif [ "$IS_ACTIVE" = "inactive" ] ; then
        echo -e -n "$ColorReset""➜ [$Bold$Blue $1$ColorReset$Normal $Red ✗ $ColorReset inactive ] "

    else
        echo -e -n "$ColorReset""➜ [$Bold$Blue $1$ColorReset$Normal $Yellow ● $ColorReset no status! ] "
    fi
}


function sysInfo() {
   echo -e -n "$Dim[Sys-Info]"
   echo -e -n "$ColorReset""➜ [$Dim Uptime$Blue$UPTIME$ColorReset$Dim ★ Kernel$Blue $KERNEL$ColorReset$Dim ★ $OS $Blue$OS_RELEASE-$OS_VERSION $ColorReset] "
}

figlet -w 120 -f slant -k "$HOSTNAME"
LoggedInUsers
echo ""
sysInfo
echo ""
resourcesInfo
echo ""
echo -e -n "$Dim[Services]"
serviceStatus docker
serviceStatus ssh
echo -e "$ColorReset"

# *************************************************************************

