#!/usr/bin/env bash

DIR="$HOME/.config/picom"

# Terminate already running bar instances
killall -q picom

# Wait until the processes have been shut down
while pgrep -u $UID -x picom >/dev/null; do sleep 1; done

# Launch the bar according to the wm you are using
t=$(xrandr -q | grep -c " connected ")

if [ "$t" = "2" ]; then
    # two monitors setup
    picom -b --config "$DIR/picom.dual.conf"
else
    # one monitor setup
    picom -b --config "$DIR/picom.conf"
fi
