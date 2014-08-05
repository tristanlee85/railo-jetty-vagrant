railo-jetty-vagrant
===================

This Vagrant setup is a simple solution for a local CF development platoform.

Prerequisites:
 - VirtualBox (https://www.virtualbox.org/wiki/Downloads)
 - Vagrant (http://www.vagrantup.com/downloads.html)

VM Details:
 - Ubuntu 12.04 (64 bit)
 - MySQL
 - Railo Express (Railo 4.2 with Jetty)

Setup:
```
git clone https://github.com/tristanlee85/railo-jetty-vagrant.git
cd railo-jetty-vagrant
git submodule init
git submodule update
vagrant up
```

Initial Boot:
 - Downloads the ```precise64``` box containing Ubuntu (if not already present)
 - Installs MySQL and configures database
 - Downloads Railo Express
 - Configures Jetty service to run on boot
 - Runs ```_cfinit.cfm``` for initial instance configuration (sets admin passwords)

Host Information:
 - VM configured for ```192.168.0.10```
 - Port forwarding from guest (80) to host (8888)

Railo Administration:
 - Default passwords for both the server and web context are ```railoadmin```

TODO:
 - Automate host configuration
 - Configurable Railo version
 - Change Jetty ```start``` script to run as a service
 - ...

Credits:
 - Billy Cravens' Railo/Tomcat project: (https://github.com/bdcravens/railo-vagrant)