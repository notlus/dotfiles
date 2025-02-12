#!/usr/bin/env bash

source "$CONFIG_DIR/environment"
source "$THEME_DIR/tokyonight"

sketchybar --add event flashspace_workspace_change

SID=1
SELECTED_PROFILE_ID=$(jq -r ".selectedProfileId" ~/.config/flashspace/profiles.json)
WORKSPACES=$(jq -r --arg id "$SELECTED_PROFILE_ID" 'first(.profiles[] | select(.id == $id)) | .workspaces[].name' ~/.config/flashspace/profiles.json)

for workspace in $WORKSPACES; do
  sketchybar --add item flashspace.$SID left \
    --subscribe flashspace.$SID flashspace_workspace_change \
    --set flashspace.$SID \
    background.color=$BAR_COLOR \
    background.corner_radius=$BAR_CORNER_RADIUS \
    background.height=$BAR_HEIGHT \
    background.padding_left=5 \
    label.padding_left=0 \
    label.padding_right=0 \
    label="$workspace" \
    padding_left=0 \
    padding_right=5 \
    script="$CONFIG_DIR/plugins/flashspace.sh $workspace"

  SID=$((SID + 1))
done
