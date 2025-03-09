#!/bin/bash
art_path=$(playerctl metadata mpris:artUrl | awk 'gsub("file://", ""); gsub("%20", "\\ ")')
echo "$art_path"
#cp "$art_path" "~/artimage.jpg"
#echo "~/artimage.jpg"
#echo "$(readlink -f /tmp/artimage.jpg)"
