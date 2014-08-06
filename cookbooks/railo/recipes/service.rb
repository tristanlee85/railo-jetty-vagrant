#
# Cookbook Name:: railo
# Recipe:: service
#











[/opt/jetty]# tar -zxf /home/user/downloads/jetty-distribution-9.2.2-SNAPSHOT.tar.gz 
[/opt/jetty]# cd jetty-distribution-9.2.2-SNAPSHOT/
[/opt/jetty/jetty-distribution-9.2.2-SNAPSHOT]# ls
bin        lib                         modules      resources  start.jar
demo-base  license-eplv10-aslv20.html  notice.html  start.d    VERSION.txt
etc        logs                        README.TXT   start.ini  webapps

[/opt/jetty/jetty-distribution-9.2.2-SNAPSHOT]# cp bin/jetty.sh /etc/init.d/jetty
[/opt/jetty/jetty-distribution-9.2.2-SNAPSHOT]# cd /opt/jetty

[/opt/jetty]# echo JETTY_HOME=`pwd` > /etc/default/jetty
[/opt/jetty]# cat /etc/default/jetty 
JETTY_HOME=/opt/jetty/jetty-distribution-9.2.2-SNAPSHOT

[/opt/jetty]# service jetty start
Starting Jetty: OK Wed Nov 20 10:26:53 MST 2013