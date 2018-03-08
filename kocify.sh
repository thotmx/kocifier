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

function set_regional_formats {
  LC_ALL=es_MX.UTF-8
}

function ubermix_kocify {
  echo 'Updating packages'
  tmp = `ubermix_update_packages`
  echo 'Installing wireless drivers'
  tmp = `ubermix_install_wireless_drivers`
  echo 'Installing software'
  tmp = `ubermix_install_software`
  # For the rest of the functions, uncomment echo
  # and add tmp = `name_function`
  # Change the wallpaper using commands
  # echo 'Changing wallpaper'
  # Change regional formats
  echo 'Changing regional formats'
  tmp = `set_regional_formats`
  # Configure input methods
  echo 'Configuring keyboard packages'
  remove_keyboard_packages
  # Change the timezone to Mexico City
  # echo 'Changing timezone'
  # Install Language Pack support for Spanish
  # echo 'Installing language support'
}



#######################
# Ubermix customization
#######################

ubermix_kocify





