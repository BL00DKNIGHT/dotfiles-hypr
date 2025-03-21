  # Aliases

alias sethost="hostnamectl set-hostname"

alias wal="wal --backend colorz"
alias walset="wal --backend colorz -i"
alias ls="lsd"
alias ll="lsd -a"
alias lsh="lsd -al"
alias nftch="fastfetch"
alias pacsearch="pacman -Ss"
alias pacdel="sudo pacman -R"
alias pacins="sudo pacman -S --needed"
alias pacupt="sudo pacman -Syu --noconfirm"
alias pacclr="sudo pacman -Rns"
alias sysupt="paru -Syu"
alias checknet="ping 8.8.8.8"
alias srm="sudo rm -rf"
alias g="git"
alias gc="git clone"
alias whatismyport="ip route get 1.1.1.1 | sed -n 's/.*dev \([^\ ]*\).*/\1/p'"
alias ...="cd ../.."
alias ..="cd .."
alias .="cd ."
alias ~="cd ~/"
alias cp="cp -r"
alias clr="clear"
alias poweroff="sudo shutdown -h now"
alias i-use-arch-btw="fastfetch"
alias yt-mp3='yt-dlp -P "~/Music/" --color=auto --extract-audio --audio-format mp3 --audio-quality 0 --embed-metadata --progress'
alias yt-mp4='yt-dlp -P "~/Videos/YT-DLP/" --format "bv*[ext=mp4]+ba[ext=m4a]/b[ext=mp4]" --embed-metadata --progress'
alias pftch='fastfetch -c ~/.config/fastfetch/pconfig.jsonc'
alias adb='HOME="$XDG_DATA_HOME"/android adb'
#alias cat="bat"

alias -s {js,json,jsonr,jsonrc,jsonc,txt,c,cpp,h,hpp,py,bat,sh,zsh,html,js,css,conf,xml}=nvim
alias -s {mp3,mp4,mp5,mkv,av1,mov,avi,wav,bmp,ogg}=mpv
alias -s pdf=zathura
alias -s sh=sh
alias -s {exe,msi}=wine64
