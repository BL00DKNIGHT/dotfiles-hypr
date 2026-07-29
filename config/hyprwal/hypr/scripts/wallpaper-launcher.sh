#!/bin/bash
#  ██╗    ██╗ █████╗ ██╗     ██╗     ██████╗  █████╗ ██████╗ ███████╗██████╗
#  ██║    ██║██╔══██╗██║     ██║     ██╔══██╗██╔══██╗██╔══██╗██╔════╝██╔══██╗
#  ██║ █╗ ██║███████║██║     ██║     ██████╔╝███████║██████╔╝█████╗  ██████╔╝
#  ██║███╗██║██╔══██║██║     ██║     ██╔═══╝ ██╔══██║██╔═══╝ ██╔══╝  ██╔══██╗
#  ╚███╔███╔╝██║  ██║███████╗███████╗██║     ██║  ██║██║     ███████╗██║  ██║
#   ╚══╝╚══╝ ╚═╝  ╚═╝╚══════╝╚══════╝╚═╝     ╚═╝  ╚═╝╚═╝     ╚══════╝╚═╝  ╚═╝
#
#  ██╗      █████╗ ██╗   ██╗███╗   ██╗ ██████╗██╗  ██╗███████╗██████╗
#  ██║     ██╔══██╗██║   ██║████╗  ██║██╔════╝██║  ██║██╔════╝██╔══██╗
#  ██║     ███████║██║   ██║██╔██╗ ██║██║     ███████║█████╗  ██████╔╝
#  ██║     ██╔══██║██║   ██║██║╚██╗██║██║     ██╔══██║██╔══╝  ██╔══██╗
#  ███████╗██║  ██║╚██████╔╝██║ ╚████║╚██████╗██║  ██║███████╗██║  ██║
#  ╚══════╝╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝
#	originally written by: gh0stzk - https://github.com/gh0stzk/dotfiles
#	rewritten for hyprland by :	 develcooking - https://github.com/develcooking/hyprland-dotfiles
#	Info    - This script runs the rofi launcher, to select
#             the wallpapers included in the theme you are in.



# Set some variables
wall_dir="${HOME}/Pictures/wallpapers"
cacheDir="${HOME}/.cache/jp/${theme}"
rofi_command="rofi -dmenu -theme ${HOME}/.config/rofi/wallSelect.rasi -theme-str ${rofi_override}"

# Create cache dir if not exists
if [ ! -d "${cacheDir}" ] ; then
        mkdir -p "${cacheDir}"
    fi


physical_monitor_size=24
monitor_res=$(hyprctl monitors |grep -A2 Monitor |head -n 2 |awk '{print $1}' | grep -oE '^[0-9]+')
dotsperinch=$(echo "scale=2; $monitor_res / $physical_monitor_size" | bc | xargs printf "%.0f")
monitor_res=$(( $monitor_res * $physical_monitor_size / $dotsperinch ))

rofi_override="element-icon{size:${monitor_res}px;border-radius:0px;}"

# Convert images in directory and save to cache dir
for imagen in "$wall_dir"/*; do
	if [ -f "$imagen" ]; then
		nombre_archivo=$(basename "$imagen")
			if [ ! -f "${cacheDir}/${nombre_archivo}" ] ; then
				convert -strip "$imagen" -thumbnail 500x500^ -gravity center -extent 500x500 "${cacheDir}/${nombre_archivo}"
			fi
    fi
done

# Select a picture with rofi
wall_selection=$(find "${wall_dir}"  -maxdepth 1  -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) -exec basename {} \; | sort | while read -r A ; do  echo -en "$A\x00icon\x1f""${cacheDir}"/"$A\n" ; done | $rofi_command)

# Set the wallpaper
[[ -n "$wall_selection" ]] || exit 1
ln -sf ${wall_dir}/${wall_selection} $HOME/.cache/current-wallpaper &
wal --backend wal -e --contrast 2.5 --saturate 0.2 -i ${wall_dir}/${wall_selection} &
awww img ${wall_dir}/${wall_selection} &
magick ${wall_dir}/${wall_selection} -region 33.3%x100%+150%+0 -blur 0x25 +region ~/.cache/lockscreen-wallpaper &
    killall -SIGUSR2 waybar
    killall -SIGUSR2 xava
    killall -SIGUSR1 cava
    cp -r $HOME/.cache/wal/colors-discord.css $HOME/.config/vesktop/themes/pywal-discord-default.theme.css
    $HOME/.config/hypr/scripts/gradience2css.sh -f $HOME/.cache/wal/pywal.json >> /dev/null
    cat $HOME/.config/hypr/scripts/gtk-transparency.css | tee -a $HOME/.config/gtk-3.0/gtk.css $HOME/.config/gtk-4.0/gtk.css >> /dev/null
    $HOME/.local/bin/pywalfox update
