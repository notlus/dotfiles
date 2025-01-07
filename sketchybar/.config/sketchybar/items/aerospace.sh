#!/usr/bin/env bash

source "$CONFIG_DIR/environment"
source "$THEME_DIR/tokyonight"

sketchybar --add event aerospace_workspace_change

for sid in $(aerospace list-workspaces --all); do
    sketchybar --add item space.$sid left \
        --subscribe space.$sid aerospace_workspace_change \
        --set space.$sid \
        label.color=$white \
        background.color=$BAR_COLOR \
        background.corner_radius=$BAR_CORNER_RADIUS \
        background.height=$BAR_HEIGHT \
        background.drawing=off \
        padding_left=0\
        padding_right=0\
        label="$sid" \
        click_script="aerospace workspace $sid" \
        script="$CONFIG_DIR/plugins/aerospace.sh $sid"
done
