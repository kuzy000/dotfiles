#!/bin/sh

while : ; do
	pid=`pidof $1`
	expected=$2
	actual=`wmctrl -lp | awk '{ print $3 }' | grep -o "$pid" | wc -l`
	[[ $expected -gt $actual ]] || break
done

windowIds=`wmctrl -lp | awk '{ print $1" "$3 }' | sed -e 's/\(0x[0-9a-f]\{8\}\) '$pid'/\1/;tx;d;:x'`

echo "$windowIds" | xargs -i i3-msg '[id="{}"] move container to workspace '$3

