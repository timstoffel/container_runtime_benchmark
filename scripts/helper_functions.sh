#!/bin/sh

# just a little helper for emphasized/colored output
#
# usage (like echo):
#   section_echo "installing python pip..."
#
function section_echo() {
    echo ""
    echo -e "\e[1m\e[93m[$1]\e[0m"
}

# just a little helper for emphasized/colored output
#
# usage (like echo):
#   notice_echo "beware of the dogs!"
#
function notice_echo() {
    echo -e "\e[96m$1\e[0m"
}

# installs an os/rpm package with zypper
#
# usage:
#   install_with_zypper tree
#
function install_with_zypper() {
    section_echo "installing $1 with zypper..."
    sudo zypper --non-interactive install $1
}

# installs an os/rpm package with zypper without gpg checks of the package
#
# usage:
#   install_with_zypper tree
#
function install_with_zypper_nogpg() {
    section_echo "installing $1 with zypper (nogpg-checks)..."
    sudo zypper --non-interactive --no-gpg install $1
}

# installs a python package with easyinstall (usually only necessary to install/upgrade pip - see next function)
#
# PYTHON_INDEX_URL needs to set before to a correct python package index url.
#
# usage:
#   install_with_easyinstall pip
#
function install_with_easyinstall() {
    section_echo "installing $1 with easy_install..."
    sudo easy_install -i $PYTHON_INDEX_URL $1
}

# installs a python package with pip
#
# Usage example:
#   $STORAGE=/opt/ansible/storage
#   ...
#   install_with_pip "ansible"
#
function install_with_pip() {
    section_echo "installing $1 with pip..."
    sudo pip3 install -i $PYTHON_INDEX_URL $1
}

# installs a python package with pip into an existing virtualenv
#
# Usage example:
#   $STORAGE=/opt/ansible/storage
#   $VIRTUALENV=/opt/ansible/.virtualenv
#   ...
#   install_with_pip "ansible"
#
function install_with_pip_virtualenv() {
    section_echo "installing $1 with pip from virtualenv '$VIRTUALENV'..."
    $VIRTUALENV/bin/pip install -i $PYTHON_INDEX_URL $1
}
