#!/bin/bash
# Requires dunst och dunstify
# Based on https://gist.github.com/sebastiencs/5d7227f388d93374cebdf72e783fbd6a

function get_volume {
    amixer -M get Master | awk 'END { print $0, value }' | awk '{print $3}'
}

function is_mute {
    amixer get Master | grep '%' | grep -oE '[^ ]+$' | grep off > /dev/null
}

function send_notification {
    volume='get_volume'
    dunstify -i audio-volume-muted-blocking -t 8 -r 2593 -u normal "Volume: ${volume}%"
}

case $1 in
    up)
        amixer set Master on > /dev/null
        amixer set Master 1+ > /dev/null
        send_notification
	;;
    down)
        amixer set Master on > /dev/null
        amixer set Master 1- > /dev/null
        send_notification
	;;
    mute)
        amixer set Master toggle > /dev/null
        if is_mute ; then
        dunstify -i audio-volume-muted -t 8 -r 2593 -u normal "Volume muted!"
        else
        send_notification
	fi
	;;
esac
