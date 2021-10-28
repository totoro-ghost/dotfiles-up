#!/usr/bin/env bash

# get the location of dir where script is in
DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
THEME="$DIR/theme"

# Options
shutdown="⏻  Shutdown"
reboot="  Reboot"
lock="  Lock"
suspend="  Suspend"
logout="  Logout"

# Confirmation
confirm_exit() {
	rofi -dmenu -i -no-fixed-num-lines -p "Are You Sure? : " -theme "$THEME"
}

# Variable passed to rofi
options="$shutdown\n$reboot\n$lock\n$suspend\n$logout"

chosen="$(echo -e "$options" | rofi -theme "$THEME" -p ">" -dmenu -selected-row 2)"
case $chosen in
    "$shutdown")
		ans=$(confirm_exit &)
		if [[ $ans == "yes" || $ans == "YES" || $ans == "y" || $ans == "Y" ]]; then
			systemctl poweroff
        else
			exit 0
        fi
        ;;
    "$reboot")
		ans=$(confirm_exit &)
		if [[ $ans == "yes" || $ans == "YES" || $ans == "y" || $ans == "Y" ]]; then
			systemctl reboot
        else
			exit 0
        fi
        ;;
    "$lock")
		if [[ -f $HOME/Scripts/i3lock/launch.sh ]]; then
			"$HOME/Scripts/i3lock/launch.sh"
		elif [[ -f /usr/bin/i3lock ]]; then
			i3lock
		elif [[ -f /usr/bin/betterlockscreen ]]; then
			betterlockscreen -l
		fi
        ;;
    "$suspend")
		ans=$(confirm_exit &)
		if [[ $ans == "yes" || $ans == "YES" || $ans == "y" || $ans == "Y" ]]; then
			mpc -q pause
			amixer set Master mute
			systemctl suspend
        else
			exit 0
        fi
        ;;
    "$logout")
		ans=$(confirm_exit &)
		if [[ $ans == "yes" || $ans == "YES" || $ans == "y" || $ans == "Y" ]]; then
			loginctl terminate-session "$(loginctl session-status | awk 'NR==1{print $1}')"
        else
			exit 0
        fi
        ;;
esac
