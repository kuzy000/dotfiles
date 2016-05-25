#!/bin/sh
display_song() {
    color=
    case $(mpc status | sed 1d | head -n1 | awk '{ print $1 }') in
    '[playing]')
        status=
        #color='#808080'
        ;;
    '[paused]')
        status=
        color='#606060'
        ;;
    esac
    echo '[{"name": "mpd", "instance": "now playing", "full_text": "'"$1"' ", "color": "'${color}'"}]'
}

(while :; do
    display_song "$(mpc current --wait)"
done) &

while :; do
    display_song "$(mpc current)"
    mpc idle player > /dev/null
done
