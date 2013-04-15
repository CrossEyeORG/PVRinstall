#!/bin/bash

echo "PVRinstall script will install SABnzbd, SickBeard, CouchPotato and headphones."
echo "Copyright (C) 2013  CrossEye"

echo "This program is free software: you can redistribute it and/or modify"
echo "it under the terms of the GNU General Public License as published by"
echo "the Free Software Foundation, either version 3 of the License, or"
echo "(at your option) any later version."

echo "This program is distributed in the hope that it will be useful,"
echo "but WITHOUT ANY WARRANTY; without even the implied warranty of"
echo "MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the"
echo "GNU General Public License for more details."

echo "You should have received a copy of the GNU General Public License"
echo "along with this program.  If not, see <http://www.gnu.org/licenses/>"

sleep 8
clear

rootcheck ()
{
echo "Checking PVRinstall.sh was ran with root."
if [[ $EUID -ne 0 ]]; then
	echo "This script must be run as root" 1>&2
	exit 1
fi
echo "Verified root"
sleep 2
}

disclaimer ()
{
clear
echo "Do you Agree to the GNU License and to the warrenty?"
echo "y=YES n=NO"
}
while [ 1 ]
do disclaimer
	read CHOICE
	case "$CHOICE" in
        "y")
            clear
			echo "Updating APT package indexes."
			sleep 2
			apt-get update -q=3
			echo "Installing dependencies."
			sleep 2
			apt-get install -y -q=3 openssh-server
			apt-get install -y -q=3 ntp
			apt-get install -y -q=3 apache2
			apt-get install -y -q=3 git
			apt-get install -y -q=3 git-core
			apt-get install -y -q=3 python
			apt-get install -y -q=3 python-cheetah
			apt-get install -y -q=3 python-configobj
			apt-get install -y -q=3 python-feedparser
			apt-get install -y -q=3 python-dbus
			apt-get install -y -q=3 python-openssl
			apt-get install -y -q=3 python-support
			apt-get install -y -q=3 python-yenc
			apt-get install -y -q=3 par2
			apt-get install -y -q=3 unrar
			apt-get install -y -q=3 unzip
			echo "Creating install locations"
			sleep 2
			mkdir -p /opt/pvrinitscripts
			mkdir -p /opt/sabnzbd
			mkdir -p /opt/sickbeard
			mkdir -p /opt/couchpotato
			mkdir -p /opt/headphones
			echo "Cloning necessary GIT repositories."
			sleep 2
			git clone git://github.com/CrossEyeORG/PVRinitScripts.git /opt/pvrinitscripts
			git clone git://github.com/sabnzbd/sabnzbd.git /opt/sabnzbd
			git clone git://github.com/midgetspy/Sick-Beard.git /opt/sickbeard
			git clone git://github.com/RuudBurger/CouchPotatoServer.git /opt/couchpotato
			git clone git://github.com/rembo10/headphones.git /opt/headphones
			echo "Setting permissions."
			sleep 2
			chmod 777 -R /opt/pvrinitscripts
			chmod 777 -R /opt/sabnzbd
			chmod 777 -R /opt/sickbeard
			chmod 777 -R /opt/couchpotato
			chmod 777 -R /opt/headphones
			echo "Everything installed."
			sleep 5
			clear
			break
		;;
		"n")     
			exit
		;; 
	esac
done         

startservices ()
{
clear
echo "Do you want to start the new services?"
echo "y=YES n=NO"
}
while [ 1 ]
do startservices
	read CHOICE
	case "$CHOICE" in
        "y")
			service sabnzbd start
			service sickbeard start
			service couchpotato start
			service headphones start
			echo "Services should now be started."
			sleep 5
			clear
			break
		;;
		"n")     
		;; 
	esac
done

echo "Installation Complete."
exit 100