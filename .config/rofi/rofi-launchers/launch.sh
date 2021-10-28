#!/usr/bin/env bash

DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
THEME="$DIR/theme"

rofi -matching regex -show drun -modi drun -theme "$THEME"
# rofi -no-lazy-grab \
#     -show drun \
#     -modi drun \
#     -disable-history \
#     -drun-display-format "{name} {generic} {exec} {categories} {keywords}" \
#     -drun-match-fields name\
#     -sort

