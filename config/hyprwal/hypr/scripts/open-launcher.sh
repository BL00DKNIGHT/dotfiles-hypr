#!/usr/bin/env sh

pidww=$(pidof wofi; pidof rofi)
if [ -z "$pidww" ] ; then
    wofi --show drun
fi
