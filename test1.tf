provider "aws" {
access_key = "AKIAWKKCMNNPPEE2NONT"
secret_key = "SECRET_KEY"
region = "us-east-1"
}

#resources => plans
resource "aws_instance" "my_Ubuntu" {
  count= 1
  ami="ami-0400a1104d5b9caa1"
  instance_type="t2.micro"
  vpc_security_group_ids = [aws_security_group.security_group.id]
   
  tags={
    Name= "My Ubuntu server"
    Owner = "ildevelop"
    Project="Terraform tutorial "
  }
  # bootraping  
   #user_data = file("user_data.sh")
   user_data = templatefile("user_data.sh.tpl",{
     username="ildevelop"
     names=["John", "Bob", "Max"]
   })
   //  lifecycle if one of ignore_data change not need update/create new instance 
   lifecycle {
      ignore-changes = ["ami","user_data"],
      create_before_destroy = true   // create new one and after destroy the old instance
  }  

  #add dependence (which resource would start first)
  depends_on = [aws_instance.my_server_db]
}

resource "aws_instance" "my_server_db" {
  ami =           "ami-03a71cec707bfc1dd"
  instance_type = "t3.micro"
  vpc_security_group_ids=[aws_security_group.security_group.id]
}
 
 // create elastic IP address for my_Ubuntu services (evrey upadte will same IP)
resource "aws_eip" "my_static_ip" {
  instance= aws_instance.my_Ubuntu.id
}

resource "aws_security_group" "security_group" {
  name        = "WebServer Security Group "
  description = "Allow TLS inbound traffic"
 # vpc_id      = "${aws_vpc.main.id}"

# create dynamic ingress 
  
dynamic "ingress" { 
   for_each = ["80","443","8080"]
   content {
    from_port   = ingress.value
    to_port     = ingress.value
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
   }
  }
  /* ingress { # incoming traffic to server
    # TLS (change to whatever ports you need)
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    # Please restrict your ingress to only necessary IPs and ports.
    # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
    cidr_blocks = ["0.0.0.0/0"] # all connections
  } */

  egress { # outcoming traffic from server
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
   }
}
