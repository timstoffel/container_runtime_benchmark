#!/bin/sh

# Script to fix the execution rights of all scripts below (necessary if you copy/sync the files from a Windows machine).
# The only problem is that you have to give this script the execution right initially ;-)

cd /opt/ansible
find . -type f -name "*.sh" -print0 | xargs -0 chmod +x
