#!/bin/bash

volume_value=$(pactl get-sink-volume $(pactl get-default-sink) | awk '{gsub(/%/, "", $5); print $5}')
volume_mute=$(pactl get-sink-mute $(pactl get-default-sink) | awk '{print $2}')
volume_status=("󰕿" "󰖀" "󰕾")
volume_status_mute=("󰝟")

icon_index=$((volume_value / 34))
volume_icon=${volume_status[icon_index]}

if [ $volume_value = "no" ]; then
    volume_icon="$volume_status_mute"
elif [ $volume_mute = "yes" ]; then
    volume_icon="$volume_status_mute"
fi

echo "$volume_icon  $volume_value%"
