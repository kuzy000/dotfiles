#!/bin/sh

file="$1"
shift

if [ -f "$file" ]; then
	id=`cat "$file"`
	notify-send.sh -p -r "$id" "$@" > "$file"
else
	notify-send.sh -p "$@" > "$file"
fi
