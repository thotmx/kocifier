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

function install_language_support {
    sudo apt-get install language-pack-es
    sudo apt-get install languaje-pack-es-base
    sudo apt-get install aspell-es
    sudo apt-get install myspell-es
    sudo apt-get install manpages-es
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
  install_language_support
}

#######################
# Ubermix customization
#######################

ubermix_kocify





