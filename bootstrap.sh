#!/bin/bash

echo "# Grabbing dependencies"
sudo apt-get install chromium-browser xorg lightdm x11-xserver-utils vim unclutter xdotool

echo "# Setting up auto login for ${USER}"
sudo sed -i 's/^#*autologin-user=.*/autologin-user='${USER}'/' /etc/lightdm/lightdm.conf

# Allows us to display our dashboard when we either "startx" or login to an X session
echo "# Setting up X session for ${USER}"
ln -fs ${PWD}/xsession ~/.xinitrc
ln -fs ${PWD}/xsession ~/.xsession

# This is where the list of URLs to cycle through goes
touch urls.txt
