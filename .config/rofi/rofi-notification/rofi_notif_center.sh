#!/usr/bin/env bash
#set -euo pipefail

##### Useful settings #####

# Directory to search for icons
directory="/usr/share/icons/Papirus/48x48/"
#In case there is no icon path provided, use appname to guess icons
use_appname=true

###########################

### Raw data
raw=$(tac /tmp/dunstlog)
appname=$(echo -n "$raw" | sed -n '1~6p')
to_rofi=$(echo -n "$raw" | sed -n '2~6p;3~6p' | sed 's/\&/&amp;/g')
icon=$(echo -n "$raw" | sed -n '4~6p' | while read -r line; do echo "$line"; done)
urgency=$(echo -n "$raw" | sed -n '5~6p')
timestamp=$(echo -n "$raw" | sed -n '6~6p')


### Create Icon list to parse through with rofi
while IFS= read -r i; do
    if [[ -f "$i" ]]; then
        full_path="$i\n"
    elif [[ -n "$i" ]]; then
        # incomplete_icon_path=$(fd "$i" "$directory" | head -1)
        incomplete_icon_path=$(find "$directory" -name "$i.svg" | head -1)
        full_path="${incomplete_icon_path}\n"
    else
        full_path="\n"
    fi
    icon_paths_list="${icon_paths_list}${full_path}"
done <<< "$icon"



### Create list of rows that are "active" i.e. low urgency for the -a flag on rofi
count=0
while IFS= read -r u; do
    if [[ "$u" == *"LOW"* ]]; then
        active_list=${active_list}${active_list:+,}$count
        count=$((count+1))
    else
        count=$((count+1))
    fi
done <<< "$urgency"



### Create list of urgent rows for rofi
count=0
while IFS= read -r u; do
    if [[ "$u" == *"CRITICAL"* ]]; then
        urgent_list=${urgent_list}${urgent_list:+,}$count
        count=$((count+1))
    else
        count=$((count+1))
    fi
done <<< "$urgency"



### Guess icon with appname
readarray -t app_array < <(echo -en "$appname")
app_array=( "${app_array[@],,}" )
##FIXME: if first notification doesnt have an icon path, notif center will only show latest notification. current workaround is to
##enable dunst startup notification
readarray -t icon_path_array < <(echo -en "$icon_paths_list")
if $use_appname; then
    for i in "${!icon_path_array[@]}"; do
        if [ -z "${icon_path_array[$i]}" ]; then
            icon_path_array[$i]="${app_array[$i]}"
        fi
    done
fi


### Bold appname
readarray -t timestamp_array < <(echo -en "$timestamp")
count=0
while IFS= read -r a; do
    # app_spaces=$(printf %-42.42s "$a")
    app_spaces=$(printf %-28.28s "$a")
    embolden_app="${embolden_app}${embolden_app:+\n}<b>$app_spaces</b>${timestamp_array[$count]}"
    count=$((count+1))
done <<< "$appname"



### insert embolden appname
summary_line=0
body_line=1
readarray -t appname_array < <(echo -en "$embolden_app")
readarray -t to_rofi_array < <(echo -en "$to_rofi")
for a in "${appname_array[@]}"; do
    app_merge="${app_merge}${app_merge:+\n}$a\n${to_rofi_array[$summary_line]}\n${to_rofi_array[$body_line]}" 
    summary_line=$((summary_line+2))
    body_line=$((body_line+2))
done



### Insert icon paths
appname_line=0
summary_line=1
body_line=2
readarray -t merged_app_array < <(echo -en "$app_merge")
for i in "${icon_path_array[@]}"; do
    merge="${merged_app_array[$body_line]}\\\0icon\\\x1f${i}"
    amend="${amend}${amend:+\n}${merged_app_array[$appname_line]}\n${merged_app_array[$summary_line]}\n$merge"
    appname_line=$((appname_line+3)) 
    summary_line=$((summary_line+3))
    body_line=$((body_line+3))
done

echo -ne "$separation"


### Final prep
separation=$(sed '0~3 s/$/\x0f/g' <(echo -en "$amend"))
final_rofi=$(sed ':a;/\x0f$/{N;s/\n//;ba}'   <(echo -n "$separation"))



### Eventual Final command to be executed
selection=$(echo -ne "$final_rofi" | rofi -markup-rows -theme ~/.config/rofi/rofi-notification/configNotif.rasi -dmenu -eh 3 -a "$active_list" -u "$urgent_list" -sep '\x0f' -p "Notification Center" -no-fixed-num-lines -lines 8 -i -no-config)


echo -ne "$final_rofi"

echo -e "\n\n\t this is it------>\n"
echo "$selection"



### If a notification was selected, delete it from the logs
if [ -n "$selection" ]; then
    remove_markup=$(echo -n "$selection" | sed -e 's/<[^>]*>//g')
    extract_date="${remove_markup:42:8}"
    remove_whitespace=$(echo -ne "$remove_markup" | sed '1~3 s/\s.*$//')
    add_timestamp="$remove_whitespace\n.*\n.*\n$extract_date\n"
    reverse_search=$(tac <(echo -ne "$add_timestamp") | sed -E ':a;N;$!ba;s/\r{0,1}\n/\\n/g')
    sed -i "N;N;N;N;N; /^$reverse_search$/d" /tmp/dunstlog
fi