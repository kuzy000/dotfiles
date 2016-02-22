setterm -blank 0 
setterm -powerdown 0 

(mpd && mpc pause) &
emacs --daemon &

[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx

