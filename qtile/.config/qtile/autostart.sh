# qtile cmd-obj -o cmd -f next_screen
# qtile cmd-obj -o cmd -f next_layout
# qtile cmd-obj -o cmd -f next_screen

#boot compton or picom if it exists
if [ -x "$(command -v compton)" ]; then
  compton &> /dev/null & 
elif [ -x "$(command -v picom)" ]; then
  picom &> /dev/null & 
fi

dex -va