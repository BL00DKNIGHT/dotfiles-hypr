#!/usr/bin/env bash

printf "\e[34m[$0]: WARNING:\n"
printf "  This script assumes that you are on a mostly clean arch install,\n"
printf "  it will attempt to install the dots and any configuration will be removed.\n"

distro_id="$(lsb_release -a | awk 'FNR == 2 {print $3}')"
aur_list="xava-git"
grouplist="games dbus scanner power docker adbusers seat video uucp storage optical lp input audio"
current_user_quoted=\"$(whoami)\"
current_user="$(whoami)"

rm -rf $HOME/.config
mkdir -p $HOME/.config/{vesktop/themes,cava,xava} $HOME/{.librewolf,Pictures/wallpapers,Videos,Music,Desktop,Downloads}

printf "\n  Adding cachyos repo.\n"
sudo pacman-key --recv-keys F3B607488DB35A47 --keyserver keyserver.ubuntu.com
sudo pacman-key --lsign-key F3B607488DB35A47
sudo pacman -U 'https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-keyring-20240331-1-any.pkg.tar.zst' \
'https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-mirrorlist-18-1-any.pkg.tar.zst' \
'https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-v3-mirrorlist-18-1-any.pkg.tar.zst' \
'https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-v4-mirrorlist-6-1-any.pkg.tar.zst' \
'https://mirror.cachyos.org/repo/x86_64/cachyos/pacman-7.0.0.r6.gc685ae6-3-x86_64.pkg.tar.zst'
sudo bash -c 'echo "[cachyos]
Include = /etc/pacman.d/cachyos-mirrorlist" >> /etc/pacman.conf'


printf "\n  Adding chaotic-aur repo.\n"
sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
sudo pacman-key --lsign-key 3056513887B78AEB
sudo pacman -U --noconfirm 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst'
sudo pacman -U --noconfirm 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'
sudo bash -c 'echo "[chaotic-aur]
Include = /etc/pacman.d/chaotic-mirrorlist" >> /etc/pacman.conf'
sudo pacman -Sy --noconfirm


printf "\n  Copying the configs.\n"
cp -ar ./config/hyprwal/* $HOME/.config/
cp -ar ./extra/librewolf/librewolf.overrides.cfg $HOME/.librewolf


printf "\n  Installing packages and dependencies.\n"
cd ./packages
case $distro_id in
  Arch) for pkg in system-base dot-base gtk font hyprland; do
      cd $pkg
      makepkg -siCc
      cd ..
    done
  ;;
  Artix) for pkg in system-base dinit-base dot-base gtk font hyprland; do
      cd $pkg
      makepkg -siCc
      cd ..
    done
  ;;
esac

paru -S --sudoloop --skipreview --cleanafter --needed ${aur_list}


printf "\n  Configuring greetd.\n"
if [ ! -f "/etc/greetd/config.toml" ]; then
  sudo bash -c "cat ./extra/greetd.toml >> /etc/greetd/config.toml"
  sudo bash -c "echo 'user =' '"${current_user_quoted}"' >> /etc/greetd/config.toml"
else
  echo "Greetd config is already present"
fi


printf "\n  Appending groups to user.\n"
sudo echo ${grouplist} | xargs -n 1 groupadd -r
sudo usermod -a -G games,dbus,scanner,power,docker,adbusers,seat,video,uucp,storage,optical,lp,input,audio ${current_user}


printf "\n  Installing pywal16 and pywalfox.\n"
pipx install pywal16
pipx install --index-url https://test.pypi.org/simple/ pywalfox==2.8.0rc1
$HOME/.local/bin/pywalfox install --browser librewolf


#printf "\n  Activating the necessary services.\n"
#case $distro_id in
#Arch) systemctl enable NetworkManager.service greetd.service
#;;
#Artix) sudo dinitctl turnstNetworkManager
#;;
#esac


printf "  Setup complete!"
printf "  Please activate the necessary services and reboot."
exit 0
