#!/bin/sh

# 
# Script to install ansible without internet connection in the vagrant local environment.
# Notice: No virtualenv here because virtualenvs are not working with mapped vagrant folders...
#

# import helper function (these will provide echo and the install* functions)
# source /opt/ansible/scripts/helper_functions.sh # need to use full path here or vagrant won't find it...

echo "Ansible Controller setup started"
echo .

PLAYBOOKS="/opt/ansible"
echo "playbooks directory='$PLAYBOOKS'"

sudo apt-get update
sudo apt-get install software-properties-common
sudo apt-add-repository ppa:ansible/ansible

echo "deb http://ppa.launchpad.net/ansible/ansible/ubuntu bionic main" | sudo tee -a /etc/apt/sources.list
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367
sudo apt update
sudo apt install ansible -y
sudo ansible --version
sudo apt install nano tree python python-setuptools python-pip -y

pip install"piprepo"
pip install"paramiko"
pip install"ansible"
pip install"yamllint"
pip install"requests"

echo "creating ansible config for current environment..."
cp $PLAYBOOKS/ansible.vagrant_dev.cfg $PLAYBOOKS/ansible.cfg

echo "changing some default settings..."
echo "export EDITOR=nano" | tee -a /home/vagrant/.bashrc
echo "alias a=ansible-playbook" | tee -a /home/vagrant/.bashrc
echo "cd $PLAYBOOKS" | tee -a /home/vagrant/.bashrc

echo "Ansible Controller setup finished."
