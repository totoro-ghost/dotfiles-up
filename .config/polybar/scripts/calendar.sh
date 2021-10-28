#!/bin/bash

CAL=$(ncal -h -b | sed "s|$(date +%e)|<i><b>$(date +%e)</b></i>|" | sed 's/[ \t]*$//')

DATE=$(date +'%A %d-%m-%Y')

echo -e "$DATE\n$CAL"

# send wrong icon so dunst don't display icon
dunstify -a "Calendar" "Calendar" "$CAL\n<u>                    </u>\n<b>$DATE</b>" -i "wrong icon" -t 4000
