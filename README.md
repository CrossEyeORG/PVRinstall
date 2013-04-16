PVRinstall
==========

PVRinstall is a simple bash script intended to be used on a Debian system that will install
SABnzbd, SickBeard, CouchPotato and Headphones from GitHub. It will also configure each
program as a service with init scripts. During the installation, you'll be prompted for
which username you want them to run with.

Just download the script to anywhere on your system, make it executable and run with sudo.
<ul>
	<li>
		<code>
			cd ~/
		</code>
	</li>
	<li>
		<code>
			wget -O ~/pvrinstall.sh https://github.com/CrossEyeORG/PVRinstall/blob/master/pvrinstall.sh
		</code>
	</li>
	<li>
		<code>
			sudo chmod +x pvrinstall.sh
		</code>
	</li>
	<li>
		<code>
			sudo ./pvrinstall.sh
		</code>
	</li>
</ul>
