#!/usr/bin/env bash

DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
THEME="$DIR/theme"

LIST="$DIR/mylist.md"

SELECT=$(cat "$LIST" | rofi -markup-rows -dmenu -p " Search emoji> " -i -theme "$THEME")

# chosen=$(cut -d' ' -f1 ~/.config/rofi/emoji/emoji.md |
#     rofi -dmenu -p " Search emoji> " -i -theme $dir/"$theme".rasi |
#     sed "s/ .*//")

# Exit if none chosen.
# [ -z "$chosen" ] && exit

# # If you run this command with an argument, it will automatically insert the
# # character. Otherwise, show a message that the emoji has been copied.
# if [ -n "$1" ]; then
# 	xdotool type "$chosen"
# else
# 	printf "$chosen" | xclip -selection clipboard
# 	# notify-send "'$chosen' copied to clipboard." &
# fi
