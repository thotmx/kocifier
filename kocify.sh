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

function remove_keyboard_packages {
  sudo apt-get remove fcitx*
}

function change_timezone {
  sudo rm /etc/localtime
  sudo ln -s /usr/share/zoneinfo/America/Mexico_City /etc/localtime
}

function ubermix_download_background_image {
	cd /tmp/
	wget https://raw.githubusercontent.com/kidsoncomputers/kocifier/master/assets/Wallpaper%204x3.png
	sudo cp 'Wallpaper 4x3.png' /usr/share/backgrounds
	sudo chmod a+rw /usr/share/backgrounds/*
}

function ubermix_configuration_background_image { 	
	gsettings set org.gnome.desktop.background picture-uri 'file:///usr/share/backgrounds/Wallpaper 4x3.png'
	gsettings set org.gnome.desktop.background picture-options 'scaled'
  gsettings set org.gnome.desktop.background primary-color '#ffffff'
}

function ubermix_background_main {
	ubermix_download_background_image
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

check_distro
# dist will have the distribution value
if [[ ${dist} = *'raspbian'* ]]; then
  echo 'Raspbian customization should be here';
fi
if [[ ${dist} = *'ubermix'* ]]; then
  #######################
  # Ubermix customization
  #######################
  ubermix_kocify
fi
