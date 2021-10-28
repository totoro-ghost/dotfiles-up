#!/bin/bash

DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
THEME="$DIR/onedark_small"

declare -a options=(
    "time table"
    "select font"
    "dunst - restart"
    "dunst - toggle visibility"
    "picom - kill"
    "picom - restart"
    "compact mode"
    "gaps mode"
    "Slideshow"
    "Save tabs - firefox"
    "Open saved tabs - firefox"
    "Screenshot"
)

choice=$(printf '%s\n' "${options[@]}" | rofi -theme "$THEME" -dmenu -i -p "select")

# if [ "$?" -eq 13 ];then
#     echo "hi"
#     exit
# fi

case $choice in
"dunst - restart")
    if pgrep -x "dunst" >/dev/null; then
        pkill dunst
        dunst
    else
        dunst
    fi
    ;;
"notify-send toggle visibility")
    if pgrep -x "dunst" >/dev/null; then
        dunstctl set-paused toggle
    else
        dunst
    fi
    ;;
"picom - kill")
    pkill picom
    ;;
"picom - restart")
    killall -qw picom
    picom -b
    ;;
"time table")
    feh ~/Pictures/time_table.jpeg --title timetable
    ;;
"select font")
    font_get=$(fc-list | cut -d':' -f2- | cut -c 2- |
        dmenu -i -l 20 -sb "#c6bcee" -nb "#282A36" -nf "#d7dae0" -sf "#282A36" \
            -fn "Iosevka Nerd Font-16" \
            -p 'Select Font> ')
    echo "$font_get" | tr -d '\n' | xclip -sel clip
    ;;
"compact mode")
    i3-msg gaps inner all set 0
    i3-msg gaps outer all set 0
    ;;
"gaps mode")
    i3-msg gaps inner all set 8
    i3-msg gaps outer all set 8
    ;;
"Save tabs - firefox")
    ~/Scripts/firefox/tabs.sh -save
    ;;
"Open saved tabs - firefox")
    ~/Scripts/firefox/tabs.sh -open
    ;;
"Screenshot")
    ~/Scripts/dmenu/dmscrot.sh
    ;;
"Slideshow")
    DIRC="$HOME/Pictures/Wallpapers"
    feh "$DIRC" "$DIRC/best_wallpapers" "$DIRC/Nature" "$DIRC/Anime" \
        -z -D 4 --class wallpaper -g 1000x562 -. -B "#282c33" --zoom fill
    ;;
*)
    exit 1
    ;;
esac