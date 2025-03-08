#!/bin/bash

battery_percentage=$(cat "/sys/class/power_supply/BAT0/capacity")
power_status=$(cat "/sys/class/power_supply/ADP0/online")

battery_icons=("󰂃" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰁹" "󰁹")
charging_icon="󰂄"
no_battery_icon="󱉝"

if [ -f "/sys/class/power_supply/BAT0/capacity" ]; then
    icon_index=$((battery_percentage / 10))
    battery_icon=${battery_icons[icon_index]}

    if [ "$power_status" = 1 ]; then
        battery_icon="$charging_icon"
    fi
fi 

if [ ! -f "/sys/class/power_supply/BAT0/capacity" ]; then
    battery_percentage="---"
    battery_icon="$no_battery_icon"
fi 

echo "$battery_icon  $battery_percentage%"
