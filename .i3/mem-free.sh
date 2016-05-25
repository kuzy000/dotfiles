#!/bin/sh
display_mem_free() {
	text=`free -h | awk 'FNR == 2 { print $4 }'`
	echo '[{"name": "mem-free", "instance": "", "full_text": " （ '"$text"' ）"}]'
}

while :; do
	display_mem_free
	sleep 2
done
