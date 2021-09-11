#!/bin/bash

# THEME=$HOME/.config/rofi/shortcuts/themes/onedark.rasi
THEME="$HOME/.config/rofi/rofi-themes/User Themes/onedark.rasi"

declare -a options=(
    "time table"
    "select font"
    "dunst - restart"
    "dunst - toggle visibility"
    "picom - kill"
    "picom - restart"
    "compact mode"
    "gaps mode"
)

choice=$(printf '%s\n' "${options[@]}" |
    rofi -theme "$THEME" -dmenu -p "select")

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
*)
    exit 1
    ;;
esac