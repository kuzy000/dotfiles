#!/bin/sh

while : ; do
	pid=`pidof $1 | sed -e 's/ /\n/g'`
	expected=$2
	actual=`wmctrl -lp | awk '{ print $3 }' | fgrep -o "$pid" | wc -l`
	[[ $expected -gt $actual ]] || break
done

for i in $pid; do
	windowIds=`wmctrl -lp | awk '{ print $1" "$3 }' | sed -e 's/\(0x[0-9a-f]\{8\}\) '$i'/\1/;tx;d;:x'`

	echo "$windowIds" | xargs -i i3-msg '[id="{}"] move container to workspace '$3
done

