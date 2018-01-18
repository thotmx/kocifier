#!/usr/bin/env bash

shopt -s extglob
set -o errtrace
set -o errexit

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
    sudo apt-get -y install $package
  done
}

function remove_keyboard_packages {
  sudo apt-get remove fcitx*
}

function ubermix_kocify {
  ubermix_update_packages
  ubermix_install_wireless_drivers
  ubermix_install_software
  # Change the wallpaper using commands
  # Install Kids Ruby
  # Change regional formats
  # Configure input methods
  remove_keyboard_packages
  # Change the timezone to Mexico City
  # Install Language Pack support for Spanish
}

function set_regional_formats {
  # Generate a new locale file for es_MX
  sudo locale-gen es_MX.UTF-8
  # Reconfigure locales
  sudo dpkg-reconfigure locales
  # Adjusting locales
  sudo update-locale LANG=es_MX.UTF-8
  sudo update-locale LC_CTYPE=es_MX.UTF-8
  sudo update-locale LC_NUMERIC=es_MX.UTF-8
  sudo update-locale LC_TIME=es_MX.UTF-8
  sudo update-locale LC_COLLATE=es_MX.UTF-8
  sudo update-locale LC_MONETARY=es_MX.UTF-8
  sudo update-locale LC_MESSAGES=es_MX.UTF-8
  sudo update-locale LC_PAPER=es_MX.UTF-8
 	sudo update-locale LC_NAME=es_MX.UTF-8
  sudo update-locale LC_ADDRES=es_MX.UTF-8
  sudo update-locale LC_TELEPHONE=es_MX.UTF-8
  sudo update-locale LC_MEASUREMENT=es_MX.UTF-8
  sudo update-locale LC_IDENTIFICATION=es_MX.UTF-8
  sudo update-locale LC_ALL=es_MX.UTF-8
}


#######################
# Ubermix customization
#######################

ubermix_kocify





