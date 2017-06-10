#!/usr/bin/env bash

shopt -s extglob
set -o errtrace
set -o errexit

#######################
# Ubermix customization
#######################

# Update packages
sudo apt-mark hold grub2-common grub-common grub-pc grub-pc-bin
sudo apt-get -y update
sudo apt-get -y upgrade

# Add wireless drivers
sudo apt-get -y purge bcmwl-kernel-source
sudo apt-get -y install firmware-b43legacy-installer
sudo apt-get -y install firmware-b43-installer

# Install software

software = `curl -sSL https://raw.githubusercontent.com/kidsoncomputers/kocifier/master/ubermix_packages`

for package in ${software[*]}
do
  sudo apt-get -y install $package
done

# Change the wallpaper using commands

# Install Kids Ruby

# Change regional formats

# Configure input methods

sudo apt-get remove fcitx*

# Change the timezone to Mexico City

# Install Language Pack support for Spanish
