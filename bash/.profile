# Sample .profile for SUSE Linux
# rewritten by Christian Steinruecken <cstein@suse.de>
#
# This file is read each time a login shell is started.
# All other interactive shells will only read .bashrc; this is particularly
# important for language settings, see below.

test -z "$PROFILEREAD" && . /etc/profile || true

### MD set paths
# include sbin in PATH
if [ -d "/sbin" ] ; then
    PATH="/sbin:$PATH"
fi
if [ -d "/usr/sbin" ] ; then
    PATH="/usr/sbin:$PATH"
fi
# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes snaps bin if it exists
if [ -d "/snap/bin" ] ; then
    PATH="$PATH:/snap/bin"
fi

export PATH=$PATH

#export GOPATH=$HOME/gopath
#export PATH=$GOPATH:$GOPATH/bin:$PATH

# set flatpak locations into XDG_DATA_DIRS
if [ -d "/var/lib/flatpak/exports/share" ] ; then
    XDG_DATA_DIRS="/var/lib/flatpak/exports/share:$XDG_DATA_DIRS"
fi

if [ -d "$HOME/.local/share/flatpak/exports/share" ] ; then
    XDG_DATA_DIRS="$HOME/.local/share/flatpak/exports/share:$XDG_DATA_DIRS"
fi

# Some applications read the EDITOR variable to determine your favourite text
# editor. So uncomment the line below and enter the editor of your choice :-)
export EDITOR=/usr/bin/vim
#export EDITOR=/usr/bin/mcedit

# For some news readers it makes sense to specify the NEWSSERVER variable here
#export NEWSSERVER=your.news.server

# Some people don't like fortune. If you uncomment the following lines,
# you will have a fortune each time you log in ;-)
#if [ -x /usr/bin/fortune ] ; then
#    echo
#    /usr/bin/fortune
#    echo
#fi

# set tty colours.
if [ "$TERM" = "linux" ]; then
    printf "\e]P0000000" # color0
    printf "\e]P19e1828" # color1
    printf "\e]P2aece92" # color2
    printf "\e]P3968a38" # color3
    printf "\e]P4414171" # color4
    printf "\e]P5963c59" # color5
    printf "\e]P6418179" # color6
    printf "\e]P7bebebe" # color7
    printf "\e]P8888888" # color8
    printf "\e]P9cf6171" # color9
    printf "\e]PAc5f779" # color10
    printf "\e]PBfff796" # color11
    printf "\e]PC4186be" # color12
    printf "\e]PDcf9ebe" # color13
    printf "\e]PE71bebe" # color14
    printf "\e]PFffffff" # color15
#   clear # removes artefacts but also removes /etc/{issue,motd}
fi