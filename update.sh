#!/usr/bin/env bash

printf "\e[34m[$0]: UPDATING CONFIGS\n"
git pull
rsync -ah ./config/hyprwal/* $HOME/.config/
rsync -ah ./extra/librewolf/librewolf.overrides.cfg $HOME/.librewolf
printf "  DONE."
