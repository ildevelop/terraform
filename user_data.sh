#!/bin/bash
yum -y update                 #update linux
yum -y install httpd          #install apache web server
myip=`crul http://169.254.169.254/latest/meta-data/local-ipv4` #get id from aws
echo "<h2> Webserver with IP: $myip</h2><br>Build by Terraform!" > /var/www/html/index.html  
sudo service httpd start      #start apache web server
chkconfig httpd on            #evry run start apache server