#!/usr/bin/env bash

printf "\e[34m[$0]: UPDATING CONFIGS\n"
git pull
rsync -avh ./config/hyprwal/* $HOME/.config/
rsync -avh ./extra/librewolf/librewolf.overrides.cfg $HOME/.librewolf
printf "  DONE."
