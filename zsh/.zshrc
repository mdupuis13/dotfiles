# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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

# docker as non-root usert requirement - MD
export DOCKER_HOST=unix:///run/user/1001/docker.sock

# set PATH so it includes snaps bin if it exists
#if [ -d "/snap/bin" ] ; then
#    PATH="$PATH:/snap/bin"
#fi

export GOPATH=$HOME/gopath
export PATH=$GOPATH:$GOPATH/bin:$PATH


## ZSH Unplugged section
# zsh_unplugged: https://github.com/mattmc3/zsh_unplugged
# a simple, ultra-fast plugin handler

# clone a plugin, identify its init file, source it, and add it to your fpath
function plugin-load {
  local repo plugdir initfile
  ZPLUGINDIR=${ZPLUGINDIR:-${ZDOTDIR:-$HOME/.config/zsh}/plugins}
  for repo in $@; do
    plugdir=$ZPLUGINDIR/${repo:t}
    initfile=$plugdir/${repo:t}.plugin.zsh
    if [[ ! -d $plugdir ]]; then
      echo "Cloning $repo..."
      git clone -q --depth 1 --recursive --shallow-submodules https://github.com/$repo $plugdir
    fi
    if [[ ! -e $initfile ]]; then
      local -a initfiles=($plugdir/*.plugin.{z,}sh(N) $plugdir/*.{z,}sh{-theme,}(N))
      (( $#initfiles )) || { echo >&2 "No init file found '$repo'." && continue }
      ln -sf "${initfiles[1]}" "$initfile"
    fi
    fpath+=$plugdir
    (( $+functions[zsh-defer] )) && zsh-defer . $initfile || . $initfile
  done
}

# if you want to compile your plugins you may see performance gains
function plugin-compile() {
  ZPLUGINDIR=${ZPLUGINDIR:-${ZDOTDIR:-$HOME/.config/zsh}/plugins}
  autoload -U zrecompile
  local f
  for f in $ZPLUGINDIR/**/*.zsh{,-theme}(N); do
    zrecompile -pq "$f"
  done
}

function plugin-update {
  ZPLUGINDIR=${ZPLUGINDIR:-$HOME/.config/zsh/plugins}
  for d in $ZPLUGINDIR/*/.git(/); do
    echo "Updating ${d:h:t}..."
    command git -C "${d:h}" pull --ff --recurse-submodules --depth 1 --rebase --autostash
    echo -e "\n"
  done
}

# Define some usefull env variables
ZPLUGINDIR=${ZPLUGINDIR:-${ZDOTDIR:-$HOME/.config/zsh}/plugins}

# make list of the Zsh plugins you use
plugins=(
  # plugins like prompts and defer that need loaded first
  romkatv/powerlevel10k  # is a power prompt https://github.com/romkatv/powerlevel10k

  # all plugins loaded afeter this line are defered
  romkatv/zsh-defer

  # all other plugins
  zsh-users/zsh-autosuggestions
  zsh-users/zsh-history-substring-search
  # ...

  # plugins like syntax highlighting that need loaded last
  zsh-users/zsh-syntax-highlighting
)

# now load your plugins
plugin-load $plugins



# make zsh/terminfo work for terms with application and cursor modes
#case "$TERM" in
#    vte*|xterm*)
#        zle-line-init() { zle -N zle-keymap-select; echoti smkx }
#        zle-line-finish() { echoti rmkx }
#        zle -N zle-line-init
#        zle -N zle-line-finish
#        ;;
#esac

# User configuration

# Vi mode
bindkey -v

bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^r' history-incremental-search-backward


# By default, there is a 0.4 second delay after you hit the <ESC> key and when the mode change is registered.
# This results in a very jarring and frustrating transition between modes.
# Let's reduce this delay to 0.1 seconds.
export KEYTIMEOUT=1


# backspace fix for certain terminals (Kitty is among them)
if [[ -n $terminfo[kbs] ]]; then
    bindkey          "$terminfo[kbs]"   backward-delete-char
    bindkey -M vicmd "$terminfo[kbs]"   backward-char
fi

if [ -e /home/mdupuis/.nix-profile/etc/profile.d/nix.sh ]; then . /home/mdupuis/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer


# computer specific code
if [[ `uname -n | cut -c-2` -eq "PP" ]]; then

    # set jdk home
    export JAVA_HOME="/usr/lib/jvm/java-11-openjdk-amd64/"


    if ! timeout 2s nc -zw1 google.com 443; then
      powershell.exe "C:\Users\DGN5557\route-wsl2.ps1"
    fi
fi

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
if [ -d $HOME/.sdkman ]; then
  export SDKMAN_DIR="$HOME/.sdkman"
  [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
fi

export QT_QPA_PLATFORMTHEME=qt5ct

# base16-shell color theme
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"

# Load bash files to zsh 
# test -f $HOME/.bashrc && source $HOME/.bashrc 
[[ -e ~/.bash_aliases ]] && source ~/.bash_aliases
[[ -e ~/.bash_functions ]] && source ~/.bash_functions

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

autoload -Uz compinit
zstyle ':completion:*' menu select
fpath+=~/.zfunc
