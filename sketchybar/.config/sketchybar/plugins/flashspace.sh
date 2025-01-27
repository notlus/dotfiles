#!/usr/bin/env bash

source "$CONFIG_DIR/environment"
source "$THEME_DIR/tokyonight"

if [ "$1" = "$WORKSPACE" ]; then
  sketchybar --set $NAME \
      label.color=$LABEL_HIGHLIGHT_COLOR \
      background.drawing=on 
else
  sketchybar --set $NAME \
      label.color=$LABEL_COLOR \
      background.drawing=off
fi
