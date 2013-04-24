PVRinstall
==========

PVRinstall is a simple bash script intended to be used on a Debian based system(Ubuntu, Linux Mint, etc) that will automatically install
SABnzbd+, SickBeard, CouchPotato and Headphones from GitHub. It will also configure each
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
			wget -O ~/pvrinstall.sh https://raw.github.com/CrossEyeORG/PVRinstall/master/pvrinstall.sh
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

After running PVRinstall.sh, all you'll need to do is kick up a web brower. Visit the below URLs to configure each program with your individual settings.

* For SABnzbd+
  (http://servername:8090/)

* For SickBeard
  (http://servername:8081/)

* For CouchPotato
  (http://servername:5050/)

* For Headphones
  (http://servername:8181/)