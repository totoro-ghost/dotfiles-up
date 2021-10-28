#!/usr/bin/env bash

DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
THEME="$DIR/theme.rasi"

rofi -no-lazy-grab -show window -modi window -theme "$THEME"