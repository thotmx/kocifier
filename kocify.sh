#!/usr/bin/env bash

shopt -s extglob
set -o errtrace
set -o errexit

dist='unknown'

function check_distro {
  if [[ -f '/etc/lsb-release' ]]; then
    distFile=`cat /etc/lsb-release`;
  elif [[ -f '/etc/os-release' ]]; then
    distFile=`cat /etc/os-release`;
  else
    distFile='No release file found';
  fi
  # Testing for ubermix, I'm not sure if it starts with capital u,
  # so bermix should work
  if [[ ${distFile} = *'bermix'* ]]; then
    dist='ubermix'
  # The same as bermix for ubermix, aspbian should work for raspbian
  elif [[ ${distFile} = *'aspbian'* ]]; then
    dist='raspbian'
  fi
}

function ubermix_update_packages {
  sudo apt-mark hold grub2-common grub-common grub-pc grub-pc-bin
  sudo apt-get -y update
  sudo apt-get -y upgrade
}

function raspbian_update_os {
  echo "================================="
  echo "= Updating OS"
  echo "================================="
  sudo apt-get -y update
  sudo apt-get -y upgrade
}

function ubermix_install_wireless_drivers {
  # Add wireless drivers
  sudo apt-get -y purge bcmwl-kernel-source
  sudo apt-get -y install firmware-b43legacy-installer
  sudo apt-get -y install firmware-b43-installer
}

function ubermix_install_software {
  software=( $(curl -sSL https://raw.githubusercontent.com/kidsoncomputers/kocifier/master/ubermix_packages) )

  for package in ${software[*]}
  do
    sudo apt-get -y install ${package}
  done
}

#https://raw.githubusercontent.com/kidsoncomputers/documentation/master/uganda/2019/install-packages.sh
function install_software {
  echo "================================="
  echo "= Installing packages"
  echo "================================="
  software=( $(curl -sSL https://raw.githubusercontent.com/roninsphere/kocifier/mexico2019/packages.txt | sed '/^ *#/d;s/#.*//' ) )
  for package in ${software[*]}
  do
    sudo apt-get -y install ${package}
  done
}


function remove_keyboard_packages {
  sudo apt-get remove fcitx*
}

function change_timezone {
  sudo rm /etc/localtime
  sudo ln -s /usr/share/zoneinfo/America/Mexico_City /etc/localtime
}

function ubermix_download_background_image {
	wget https://raw.githubusercontent.com/kidsoncomputers/kocifier/master/assets/Wallpaper%204x3.png
	sudo cp 'Wallpaper 4x3.png' /usr/share/backgrounds
	sudo chmod a+rw /usr/share/backgrounds/*
}

function raspbian_download_background_image {
	cd /tmp/
	wget https://raw.githubusercontent.com/kidsoncomputers/kocifier/master/assets/Wallpaper%204x3.png
	#sudo mkdir /usr/local/share/backgrounds
	sudo cp 'Wallpaper 4x3.png' /usr/share/rpd-wallpaper/temple.jpg
	sudo chmod a+rw /usr/share/rpd-wallpaper/temple.jpg
}

function ubermix_configuration_background_image {
	gsettings set org.gnome.desktop.background picture-uri 'file:///usr/share/rpd-wallpaper/Wallpaper 4x3.png'
	gsettings set org.gnome.desktop.background picture-options 'scaled'
  gsettings set org.gnome.desktop.background primary-color '#ffffff'
}

function ubermix_background_main {
	ubermix_download_background_image
	ubermix_configuration_background_image
}

function raspbian_background_main {
	raspbian_download_background_image
	ubermix_configuration_background_image
}

function ubermix_kocify {
  ubermix_update_packages
  ubermix_install_wireless_drivers
  ubermix_install_software
  ubermix_background_main
  # Install Kids Ruby
  # Change regional formats
  # Configure input methods
  remove_keyboard_packages
  change_timezone
  # Install Language Pack support for Spanish
}

function raspbian_kocify {
  raspbian_update_os
  install_software
  raspbian_background_main
  change_timezone
}

check_distro
# dist will have the distribution value
if [[ ${dist} = *'raspbian'* ]]; then
  echo "================================="
  echo "= Raspbian customization"
  echo "================================="
  raspbian_kocify
fi
if [[ ${dist} = *'ubermix'* ]]; then
  #######################
  # Ubermix customization
  #######################
  ubermix_kocify
fi
