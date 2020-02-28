# ntp
The role ntp enables NTP synchronization via the timedatectl service on Debian and sets the time server.
The packages NTP and NTP Date are uninstalled because they conflict with timedatectl. Normally these packages are not installed.

## Variables
The time server must be specified via defaults/main.yml. 

## Restrictions
The role only runs on Debian.