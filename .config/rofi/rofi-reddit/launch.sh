#!/bin/bash
#
# Use: Open a subreddit using a list, adding tags
# Dependencies: dmenu

# configuration

DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
THEME="$DIR/theme"

BROWSER="firefox --new-tab"

# prompt on dmenu, use your own or install feather.ttf
R_DIR="$HOME/Documents/reddit"

if [ ! -d "$R_DIR" ]; then
    rofi -e "Folder dosen't exists :-(" 
    exit 1
fi

declare -a LISTS=(
    "linux"
    "anime"
    "engineering"
    "games"
    "india"
    "mobile"
    "other"
    "programming"
    "technology"
)

# iterate over the list
for l in ${LISTS[*]}; do

    # add items
    LIST=${LIST}$(cat "${R_DIR}/${l}")

    # style using markup
    LIST=$(echo "$LIST" | sed "s|(|<span weight='light' size='small'>(<i>|" | sed "s|)|</i>)</span>|")

    # add new line
    LIST=${LIST}$'\n' 
done

# get the choice
CHOICE=$(echo "$LIST" |rofi -dmenu -matching regex -i -multi-select -p "樓 " -markup-rows -theme "$THEME")

# nothing selected
if [ -z "$CHOICE" ]; then
    exit 0
fi

FINAL_LIST=""

# iterate over choices and remove the tags
while IFS= read -r item; do

    # get the subreddit name
    temp=$(echo "${item}" | cut -d' ' -f1)

    # add plus in between
    FINAL_LIST=$FINAL_LIST"+"$temp
done <<< "$CHOICE"

# remove the + form start, added above
FINAL_LIST=${FINAL_LIST#?};

# echo "$FINAL_LIST"

$BROWSER "https://reddit.com/r/$FINAL_LIST"