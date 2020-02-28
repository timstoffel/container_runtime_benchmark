#!/bin/sh

#
# Script to install some dev tools for ansible in an EDC Suse SLES 12.X environment where we have no internet available.
# No package in here is necessary to execute ansible playbooks
#

zypper -n install mc
zypper -n install tree
zypper -n install htop
