#!/usr/bin/env sh

pidww=$(pidof wofi; pidof rofi)
if [ -z "$pidww" ] ; then
    wall_selection="$((cd $HOME/Pictures/wallpapers && ls *.{png,jpg}) | wofi -W 400 --show dmenu)"
else
    exit 0
fi

apply_success() {
    notify-send -t 1500 'Success, applying'

    echo '1. Linking'
    ln -sf $HOME/Pictures/wallpapers/${wall_selection} $HOME/.cache/current-wallpaper &&
    echo 'Done'
    echo '2. Colors'
    $HOME/.local/bin/wal --backend wal -e --contrast 2.5 --saturate 0.1 -i $HOME/.cache/current-wallpaper &&
    echo 'Done'
    echo '3. Wallpaper'
    awww img $HOME/Pictures/wallpapers/${wall_selection} &
    echo 'Done'
}

reload_config() {
    echo '4. Reloading'
    killall -USR2 waybar
    killall -USR2 xava
    killall -USR1 cava
    cp -r $HOME/.cache/wal/colors-discord.css $HOME/.config/vesktop/themes/pywal-discord-default.theme.css
    $HOME/.config/hypr/scripts/gradience2css.sh -f $HOME/.cache/wal/pywal.json
    cat $HOME/.config/hypr/scripts/gtk-transparency.css | tee -a $HOME/.config/gtk-3.0/gtk.css $HOME/.config/gtk-4.0/gtk.css
    $HOME/.local/bin/pywalfox update
    echo 'Done'
}

intensive_config() {
    echo '5. Lockscreen'
    magick $HOME/.cache/current-wallpaper -region 33.3%x100%+150%+0 -blur 0x12 +region ~/.cache/lockscreen-wallpaper
    notify-send -t 1000 'Done'
}

failure_cancel() {
    notify-send -t 1500 'Failure/Cancelled'
    exit 0
}

if [[ -n $wall_selection ]]; then
    echo "Took file: $wall_selection"
    apply_success
    reload_config
    intensive_config
    exit 1
else
    failure_cancel
fi
