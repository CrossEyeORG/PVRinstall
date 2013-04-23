#!/bin/bash

echo "Checking PVRinstall.sh was ran with root."
if [[ $EUID -ne 0 ]]; then
	echo "This script must be run as root" 1>&2
	exit 1
fi
echo "Verified root"
sleep 2

disclaimer ()
{
clear
echo "PVRinstall script will install SABnzbd+, SickBeard, CouchPotato and Headphones."
echo "Copyright (C) 2013  CrossEye"
echo ""
echo "This program is free software: you can redistribute it and/or modify"
echo "it under the terms of the GNU General Public License as published by"
echo "the Free Software Foundation, either version 3 of the License, or"
echo "(at your option) any later version."
echo ""
echo "This program is distributed in the hope that it will be useful,"
echo "but WITHOUT ANY WARRANTY; without even the implied warranty of"
echo "MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the"
echo "GNU General Public License for more details."
echo ""
echo "You should have received a copy of the GNU General Public License"
echo "along with this program.  If not, see <http://www.gnu.org/licenses/>"
echo ""
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
			apt-get update -q=2
			echo "Installing dependencies."
			sleep 2
			apt-get install -y -q=2 openssh-server
			apt-get install -y -q=2 ntp
			apt-get install -y -q=2 apache2
			apt-get install -y -q=2 git
			apt-get install -y -q=2 git-core
			apt-get install -y -q=2 python
			apt-get install -y -q=2 python-cheetah
			apt-get install -y -q=2 python-configobj
			apt-get install -y -q=2 python-feedparser
			apt-get install -y -q=2 python-dbus
			apt-get install -y -q=2 python-openssl
			apt-get install -y -q=2 python-support
			apt-get install -y -q=2 python-yenc
			apt-get install -y -q=2 python-notify
			apt-get install -y -q=2 par2
			apt-get install -y -q=2 unrar
			apt-get install -y -q=2 unzip
			apt-get install -y -q=2 sabnzbdplus
			apt-get install -y -q=2 sabnzbdplus-theme-mobile
			echo "Creating install locations"
			sleep 2
			mkdir -p /opt/pvrinitscripts
			mkdir -p /opt/sickbeard
			mkdir -p /opt/couchpotato
			mkdir -p /opt/headphones
			echo "Cloning necessary GIT repositories."
			sleep 2
			git clone git://github.com/CrossEyeORG/PVRinitScripts.git /opt/pvrinitscripts
			git clone git://github.com/midgetspy/Sick-Beard.git /opt/sickbeard
			git clone git://github.com/RuudBurger/CouchPotatoServer.git /opt/couchpotato
			git clone git://github.com/rembo10/headphones.git /opt/headphones
			echo "Setting permissions."
			sleep 2
			chmod 777 -R /opt/pvrinitscripts
			chmod 777 -R /opt/sickbeard
			chmod 777 -R /opt/couchpotato
			chmod 777 -R /opt/headphones
			echo "Everything installed."
			sleep 5
			clear
			break
		;;
		"n")
			echo "Installation abouted, nothing has been install."
			exit
		;; 
	esac
done         

initinstall ()
{
clear
echo "Would you like the init scripts to be installed?"
echo "y=YES n=NO"
}
while [ 1 ]
do initinstall
	read CHOICE
	case "$CHOICE" in
		"y")
			break
		;;
		"n")
			echo "Installation Complete without the init scripts installed."
			exit
		;; 
	esac
done	

initconfig ()
{
clear
echo "Which username do you want each new service to run with?"
}
while [ 1 ]
do initconfig
	read USRNAME
	echo "Configuring specified username."
	sleep 2
	sed -i -e "s/USER=/USER=$USRNAME/g" /etc/default/sabnzbdplus
	sed -i -e "s/CHANGEME/$USRNAME/g" /opt/pvrinitscripts/SickBeard.sh
	sed -i -e "s/CHANGEME/$USRNAME/g" /opt/pvrinitscripts/CouchPotato.sh
	sed -i -e "s/CHANGEME/$USRNAME/g" /opt/pvrinitscripts/Headphones.sh
	echo "Copying configured init scripts to /etc/init.d/."
	sleep 2
	cp /opt/pvrinitscripts/SickBeard.sh /etc/init.d/sickbeard
	cp /opt/pvrinitscripts/CouchPotato.sh /etc/init.d/couchpotato
	cp /opt/pvrinitscripts/Headphones.sh /etc/init.d/headphones
	echo "Making the new init scripts executable."
	sleep 2
	chmod +x /etc/init.d/sickbeard
	chmod +x /etc/init.d/couchpotato
	chmod +x /etc/init.d/headphones
	echo "Updating the systems services list."
	sleep 2
	update-rc.d sickbeard defaults
	update-rc.d couchpotato defaults
	update-rc.d headphones defaults
	break
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
			clear
			service sabnzbdplus start
			service sickbeard start
			service couchpotato start
			service headphones start
			echo "Services should now be started."
			sleep 5
			break
		;;
		"n")
			echo "Installation complete but services have not been started yet."
			exit
		;; 
	esac
done

clear
echo "Installation Complete."
exit 100