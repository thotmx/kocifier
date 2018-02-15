#!/bin/bash

function ubermix_download_background_image {
	cd /tmp/
	wget http://www.kidsoncomputers.org/data/backgrounds/ubermix-2.2L-koc-es-background.jpg
	sudo cp ubermix-2.2L-koc-es-background.jpg /usr/share/backgrounds
	sudo chmod a+rw /usr/share/backgrounds/*
}

function ubermix_configuration_background_image { 	
	gsettings set org.gnome.desktop.background picture-uri file:///usr/share/backgrounds/ubermix-2.2L-koc-es-background.jpg
	gsettings set org.gnome.desktop.background picture-options 'stretched'
}

function ubermix_background_main {
	ubermix_download_background_image
	ubermix_configuration_background_image
}

ubermix_background_main
