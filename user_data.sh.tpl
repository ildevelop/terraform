#!/bin/bash
yum -y update                 #update linux
yum -y install httpd          #install apache web server
myip=`crul http://169.254.169.254/latest/meta-data/local-ipv4` #get id from aws
cat <<EOF > /var/www/html/index.html
<html>
<h2>Hello ${username}</h2> <br>
%{ for x in names ~}
Hello ${x}  <br>
%{ endfor ~}
 
</html>
EOF
sudo service httpd start
chkconfig httpd on            #evry run start apache server