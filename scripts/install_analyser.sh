#!/bin/sh

# 
# Script to install ansible without internet connection in the vagrant local environment.
# Notice: No virtualenv here because virtualenvs are not working with mapped vagrant folders...
#

# import helper function (these will provide echo and the install* functions)
# source /opt/ansible/scripts/helper_functions.sh # need to use full path here or vagrant won't find it...

echo "analyser setup started"
echo .

sudo apt-get update
sudo apt-get install software-properties-common
sudo apt install python3 python3-pip -y

pip3 install andas bokeh pyproj
pip3 install jupyter

echo "changing some default settings..."
echo "export EDITOR=nano" | tee -a /home/vagrant/.bashrc
echo "cd /opt/auswertung" | tee -a /home/vagrant/.bashrc

echo "analyser setup finished."
