#!/bin/bash

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

ubermix_background_main
