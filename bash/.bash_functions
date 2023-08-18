# this function uses spark bash script from https://github.com/holman/spark
function sine_wave() {
    SIN=$(python -c "from math import *;print map( lambda x: ceil(6*sin((x+$i)*pi/5)), range($(tput cols)) )" | tr -d '[]' | spark)
    echo -ne $SIN\\r
}


########################
# git helper functions #
########################
# git prompt combine state
function gb() {
   echo -n '[' && git branch 2>/dev/null | grep '^*' | colrm 1 2 | tr -d '\n' && echo  -n ']'
}

function git_branch() {
   gb | sed -r 's/[\[\]]//g'
}

# Function to show the current branch name
function git_current_branch() {
    git branch 2&>1 | grep \* | cut -c 3-
}

function find_git_branch() {
    # $1 == starting folder
    # $2 == git command
    # echo "0 -> $0"
    # echo "1 -> $1"
    # echo "2 -> $2"

    set -x
    find $1 -exec test -d {}/.git \;  -print -execdir git -C {} --no-pager branch --list "$2" \;
}

function find_in_git_repos() {
    # $1 == starting folder
    # $2 == regex to search for
    echo "0 -> $0"
    echo "1 -> $1"
    echo "2 -> $2"

    set -x

    find $1 -exec test -d {}/.git \;  -print -exec egrep "$2" \;
}
