#!/usr/bin/env bash

source "$CONFIG_DIR/environment"
source "$THEME_DIR/tokyonight"

FRONT_APP_LABEL_COLOR="$white"
# FRONT_APP_BACKGROUND_BORDER_COLOR="$red"

sketchybar --add item front_app_spacer_left left \
           --set      front_app_spacer_left \
                      background.drawing=off

sketchybar --add item  front_app left \
           --subscribe front_app front_app_switched \
           --set       front_app \
                       background.drawing=off \
                       background.color="$BAR_COLOR" \
                       label.color="$FRONT_APP_LABEL_COLOR" \
                       label.padding_left=0 \
                       label.padding_right=0 \
                       icon.color=$FRONT_APP_LABEL_COLOR \
                       icon.font="sketchybar-app-font:Regular:16.0" \
                       script="$PLUGIN_DIR/front_app.sh"

# sketchybar --add item front_app_spacer_right left \
#            --set      front_app_spacer_right \
#                       background.drawing=off
#
# sketchybar --add bracket front_app_bracket front_app_spacer_left front_app front_app_spacer_right \
#            --set         front_app_bracket \
#                          background.border_color="$FRONT_APP_BACKGROUND_BORDER_COLOR" \
#                          background.corner_radius="$BRACKET_BACKGROUND_CORNER_RADIUS" \
#                          background.border_width="$BRACKET_BACKGROUND_BORDER_WIDTH"
