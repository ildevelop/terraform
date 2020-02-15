provider "aws" {
access_key = "AKIAWKKCMNNPPEE2NONT"
secret_key = "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"
region = "us-east-1"
}

#resources => plans
resource "aws_instance" "my_Ubuntu" {
  count= 1
  ami="ami-0400a1104d5b9caa1"
  instance_type="t2.micro"
  vpc_security_group_ids = [aws_security_group.security_group.id] # "sg-11111111"
   
  tags={
    Name= "My Ubuntu server"
    Owner = "ildevelop"
    Project="Terraform tutorial "
  }
  # bootraping  
  #remove all spaces and //comments before run 
  user_data = <<EOF
#!/bin/bash
yum -y update                 //update linux
yum -y install httpd          //install apache web server
myip=`crul http://169.254.169.254/latest/meta-data/local-ipv4` //get id from aws
echo "<h2> Webserver with IP: $myip</h2><br>Build by Terraform!" > /var/www/html/index.html  
sudo service httpd start      //start apache web server
chkconfig httpd on            //evry run start apache server
EOF
}
resource "aws_security_group" "security_group" {
  name        = "WebServer Security Group "
  description = "Allow TLS inbound traffic"
  vpc_id      = "${aws_vpc.main.id}"

  ingress { # incoming traffic to server
    # TLS (change to whatever ports you need)
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    # Please restrict your ingress to only necessary IPs and ports.
    # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
    cidr_blocks = ["0.0.0.0/0"] # all connections
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress { # outcoming traffic from server
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
   }
}
