#!/bin/sh

# 
# Script to install ansible without internet connection in the vagrant local environment.
# Notice: No virtualenv here because virtualenvs are not working with mapped vagrant folders...
#

# import helper function (these will provide section_echo and the install* functions)
# source /opt/ansible/scripts/helper_functions.sh # need to use full path here or vagrant won't find it...

section_echo "Ansible Controller setup started"
echo .

PLAYBOOKS="/opt/ansible"
echo "playbooks directory='$PLAYBOOKS'"
# STORAGE="$PLAYBOOKS/storage"
# echo "storage directory='$STORAGE'"
# PYTHON_INDEX_URL="file://$STORAGE/python/repo/simple"
# echo "python package index='$PYTHON_INDEX_URL'"

sudo apt-get update
sudo apt-get install software-properties-common
sudo apt update
sudo apt install python3-pip -y
sudo pip3 install "ansible"
sudo ansible --version
sudo apt install nano -y

sudo pip3 install "piprepo"
sudo pip3 install "paramiko"
sudo pip3 install "ansible"
sudo pip3 install "yamllint"
sudo pip3 install "requests"
sudo pip3 install "jinja2"
sudo pip3 install "pyYAML"
sudo pip3 install "docker"

section_echo "creating ansible config for current environment..."
cp $PLAYBOOKS/ansible.vagrant_dev.cfg $PLAYBOOKS/ansible.cfg

section_echo "changing some default settings..."
echo "export EDITOR=nano" | tee -a /home/vagrant/.bashrc
echo "alias a=ansible-playbook" | tee -a /home/vagrant/.bashrc
echo "cd $PLAYBOOKS" | tee -a /home/vagrant/.bashrc

section_echo "Ansible Controller setup finished."
