#!/bin/bash
#

THEME="$HOME/.config/rofi/rofi-themes/User Themes/onedark.rasi"

declare -a options=(
    "Slideshow"
    "TODO"
    "Change Background"
    "Save tabs - firefox"
    "Open saved tabs - firefox"
    "Screenshot"
    "Increase Opacity - alacritty"
    "Decrease Opacity - alacritty"
)

choice=$(printf '%s\n' "${options[@]}" | rofi -theme "$THEME" -dmenu -p "select")

case $choice in
"Slideshow")
    DIRC="/media/antihero/Data/PersonalStuff/Wallpaper"
    feh "$DIRC" "$DIRC/best_wallpapers" "$DIRC/Nature" "$DIRC/Anime" \
        -z -D 4 --class wallpaper -g 1000x562 -. -B "#282c33" --zoom fill
    ;;
'TODO')
    typora ~/Documents/study/todo.md
    ;;
'Change Background')
    alacritty -e ranger ~/Pictures/Wallpapers
    # ~/Scripts/wallpaper.sh
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
"Increase Opacity - alacritty")
    ~/Scripts/dmenu/src/alacritty_opacity.sh -inc
    ;;
"Decrease Opacity - alacritty")
    ~/Scripts/dmenu/src/alacritty_opacity.sh -dec
    ;;
*)
    exit 1
    ;;
esac
